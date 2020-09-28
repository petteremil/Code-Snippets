/*
 A nice little combo of a couple of stack posts for detecting when the google translate dropdown changes the page language, the reason for two values in orig value
 is because the page it was used on was using the nb value for norwegian-bokmål, which the google widget doesn't seem to support, so initial value is nb, and no is what google resets the page to
 (the widget itself was initiated with page language as 'no', if nb was chosen, then the reset lang= value was 'auto' which I didn't want to use..)
*/

var origValue = 'nb;no';
$(function () {

    var htmlDoc = document.querySelector('html');

    var observer = new MutationObserver(function (mutations) {
        mutations.forEach(function (mutation) {
            if (mutation.type == "attributes" && mutation.attributeName == 'lang') {
                console.log("attribute lang changed");
                console.log(mutation);
                var lang = htmlDoc.getAttribute("lang");
                console.log(lang);
                var validOrigLangs = origValue.split(';');
                if (!validOrigLangs.includes(lang)) {
                    switchToTranslations(true);
                } else {
                    switchToTranslations(false);
                }
            }
        });
    });

    observer.observe(htmlDoc, {
        attributes: true //configure it to listen to attribute changes
    });

});
