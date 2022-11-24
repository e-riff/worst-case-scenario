<?php

namespace App\Model;

class SearchManager extends AbstractManager
{
    public function searchEngine(string $research): false|array
    {
        $intResearch = is_numeric($research) ? intval($research) : 0;

        if (strlen($research) == 1) {
            $regex = ".*\\b[" . strtolower($research) . strtoupper($research) . "].*";
            $statement = $this->pdo->prepare("SELECT id FROM " . self::TABLE .
                " WHERE name REGEXP :regex LIMIT 200");
            $statement->bindValue(':regex', $regex, \PDO::PARAM_STR);
            $statement->execute();
        } else {
            $statement = $this->pdo->prepare("SELECT id FROM " . self::TABLE .
                " WHERE name LIKE :research1 OR year= :research2 LIMIT 200");
            $statement->bindValue(':research1', "%" . $research . "%", \PDO::PARAM_STR);
            $statement->bindValue(':research2', $intResearch, \PDO::PARAM_INT);
            $statement->execute();
        }
        return $statement->fetchALL();
    }
}
