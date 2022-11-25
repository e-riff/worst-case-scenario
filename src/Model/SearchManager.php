<?php

namespace App\Model;

class SearchManager extends AbstractManager
{
    public const TABLE = 'item';

    public function searchEngine(string $research)
    {
        $statement = $this->pdo->prepare("SELECT i.*, l.id AS like_Id, l.good_or_bad  FROM " .
            self::TABLE . " AS i " .
            "LEFT JOIN like_or_dislike AS l ON i.id=l.item_id AND l.user_id=" . $_SESSION['user_id'] .
            " WHERE i.name LIKE :research OR i.address LIKE :test");
        $statement->bindValue(':research', "%" . $research . "%", \PDO::PARAM_STR);
        $statement->bindValue(':test', "%$research%", \PDO::PARAM_STR);
        $statement->execute();
        return $statement->fetchAll();
    }
}
