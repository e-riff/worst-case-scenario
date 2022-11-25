const likeOrDislikes = document.querySelectorAll("a[data-item]");

for (likeOrDislike of likeOrDislikes) {
    likeOrDislike.addEventListener('click', function (event) {
        event.preventDefault();
        event.stopPropagation();
        ajaxRequest(event.target.dataset.item, event.target.dataset.val);
    })
}

function ajaxRequest(itemId, newLikeValue) {
    url = `/likeOrDislike?itemId=${itemId}&newLikeValue=${newLikeValue}`;
    fetch(url)
        .then(function (response) {
            return response.json()
        })
        .then(function (json) {
            const poop = document.querySelector(`a[data-item="${itemId}"] > img.poop`);
            const counter = document.querySelector(`p.counter[data-item="${itemId}"]`);
            const unicorn = document.querySelector(`a[data-item="${itemId}"] > img.unicorn`);
            if (json.response == 'inserted' || json.response == 'updated') {
                if (newLikeValue == 1) {
                    poop.setAttribute("src", "/assets/images/pooFull.png");
                    unicorn.setAttribute("src", "/assets/images/unicornBW.png");
                }
                if (newLikeValue == -1) {
                    poop.setAttribute("src", "/assets/images/pooEmpty.png");
                    unicorn.setAttribute("src", "/assets/images/unicorn.png");
                }
            } else {
                poop.setAttribute("src", "/assets/images/pooEmpty.png");
                unicorn.setAttribute("src", "/assets/images/unicornBW.png");
            }
            counter.innerHTML = json.sumFav[0].favSum;
        })
}
