<?php

namespace App\Model;

use PDO;

class AddOrDislikeManager extends AbstractManager
{
    public const TABLE = 'like_or_dislike';

    public function likeOrDislikeItem(int $itemId, int $newLikeValue)
    {
        $statement = $this->pdo->prepare("SELECT * FROM " . self::TABLE .
            " WHERE item_id=:itemId AND user_id=:userId");
        $statement->bindValue('item_id', $itemId, PDO::PARAM_INT);
        $statement->bindValue('userId', $_SESSION['user_id'], PDO::PARAM_INT);
        $statement->execute();
        $oldLikeValue = $statement->fetch();

        if (is_null($oldLikeValue)) {
            $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE .
                "(item_id, user_id, good_or_bad) VALUES (:item_id, :user_id, :good_or_bad)");
            $statement->bindValue('item_id', $itemId, PDO::PARAM_INT);
            $statement->bindValue('user_id', $_SESSION['user_id'], PDO::PARAM_INT);
            $statement->bindValue(':good_or_bad', $newLikeValue, PDO::PARAM_INT);
            $statement->execute();
            return 'Inserted';
        } else {
            if ($oldLikeValue['good_or_bad'] == $newLikeValue) {
                $statement = $this->pdo->prepare("DELETE FROM " . self::TABLE . " WHERE id=:id");
                $statement->bindValue('id', $oldLikeValue["id"], PDO::PARAM_INT);
                $statement->execute();
                return 'deleted';
            } else {
                $statement = $this->pdo->prepare("UPDATE " . self::TABLE .
                    " SET good_or_bad = :good_or_bad WHERE id = :id");
                $statement->bindValue('good_or_bad', $newLikeValue, PDO::PARAM_INT);
                $statement->bindValue('id', $oldLikeValue['id'], PDO::PARAM_INT);
                $statement->execute();
                return "updated";
            }
        }
    }
}
