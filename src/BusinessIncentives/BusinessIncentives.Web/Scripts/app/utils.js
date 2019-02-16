var Utils = {};
Utils.constants = {};

Utils.baseUrl = getBaseUrl();

function getBaseUrl() {
    var root = null;

    if (document.body) {
        root = document.body.getAttribute('data-root');
    }

    if (!root) {
        return '/';
    }

    return root;
}