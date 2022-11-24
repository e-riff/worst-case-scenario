<?php

namespace App\Model;

class AddItemManager extends AbstractManager
{
    public const TABLE = 'item';

    public function addItem(array $item)
    {
        $statement = $this->pdo->prepare("INSERT INTO " . static::TABLE . " (`name`, `adress`, `region_id`, `image`, `description` `user_id` `postcode`) 
        VALUES (:name, :adress, :region, :image, :description, :id, :postcode)");
        $statement->bindValue(':name', $item['title'], \PDO::PARAM_STR);
        $statement->bindValue(':adress', $item['adress'], \PDO::PARAM_STR);
        $statement->bindValue(':region', $item['region'], \PDO::PARAM_INT);
        $statement->bindValue(':image', $item['image'], \PDO::PARAM_STR);
        $statement->bindValue(':description', $item['description'], \PDO::PARAM_STR);
        $statement->bindValue(':postcode', $item['postcode'], \PDO::PARAM_INT);
        $statement->execute();
        return $this->pdo->lastInsertId();
    }
}
