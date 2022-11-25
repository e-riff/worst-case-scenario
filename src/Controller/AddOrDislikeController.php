<?php

namespace App\Controller;

use App\Model\AddOrDislikeManager;

class AddOrDislikeController extends AbstractController
{
    public function likeOrDislike($itemId, $newLikeValue)
    {
        $addOrDislikeManager = new AddOrDislikeManager();
        $result['response'] = $addOrDislikeManager->likeOrDislikeItem($itemId, $newLikeValue);
        return json_encode($result);
    }
}
