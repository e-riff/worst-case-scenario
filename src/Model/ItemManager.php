<?php

namespace App\Model;

use PDO;

class ItemManager extends AbstractManager
{
    public const TABLE = 'item';

    public function addItem(array $item)
    {
        $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE .
            " (`name`, `address`, `region_id`, `image`, `description`, `user_id`, `postcode`)
        VALUES (:name, :address, :region_id, :image, :description, :id, :postcode)");

        $statement->bindValue(':name', $item['title'], \PDO::PARAM_STR);
        $statement->bindValue(':address', $item['address'], \PDO::PARAM_STR);
        $statement->bindValue(':region_id', $item['region'], \PDO::PARAM_INT);
        $statement->bindValue(':category', $item['category'], \PDO::PARAM_INT);
        $statement->bindValue(':image', $item['file'], \PDO::PARAM_STR);
        $statement->bindValue(':description', $item['description'], \PDO::PARAM_STR);
        $statement->bindValue(':postcode', $item['postcode'], \PDO::PARAM_INT);
        $statement->bindValue(':id', $item['id'], \PDO::PARAM_INT);
        $statement->execute();
        return $this->pdo->lastInsertId();
    }

    public function selectAllWithLike()
    {
        $statement = $this->pdo->query("SELECT i.*, l.id AS like_Id, l.good_or_bad  FROM " . self::TABLE . " AS i " .
            "LEFT JOIN like_or_dislike AS l ON i.id=l.item_id");
        return $statement->fetchAll();
    }
}
