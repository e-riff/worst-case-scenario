<?php

namespace App\Controller;

use App\Model\AddOrDislikeManager;

class AddOrDislikeController extends AbstractController
{
    public function likeOrDislike($itemId, $newLikeValue)
    {
        $result = [];

        $addOrDislikeManager = new AddOrDislikeManager();

        $result['response'] = $addOrDislikeManager->likeOrDislikeItem($itemId, $newLikeValue);

        $item = [];

        $item[0]['id'] = $itemId;

        $result['sumFav'] =
            $addOrDislikeManager->sumLike($item);

        return json_encode($result);
    }
}
