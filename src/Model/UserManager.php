<?php

namespace App\Model;

class UserManager extends AbstractManager
{
    public const TABLE = 'user';

    public function selectByOneByPseudo(string $pseudo): array|false
    {
        $query = "SELECT * FROM " . self::TABLE . " WHERE pseudo=:pseudo";
        $statement = $this->pdo->prepare($query);
        $statement->bindValue('email', $pseudo);
        $statement->execute();

        return $statement->fetch();
    }
}
