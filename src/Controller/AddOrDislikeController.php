<?php

namespace App\Controller;

use App\Model\AddOrDislikeManager;

class AddOrDislikeController extends AbstractController
{
    public function likeOrDislike($itemId, $newLikeValue)
    {
        $addOrDislikeManager = new AddOrDislikeManager();
        return json_encode(['action' => $addOrDislikeManager->likeOrDislikeItem($itemId, $newLikeValue)]);
    }
}
