angular.module('jaldi.utils', [])
.factory('utils', ['$rootScope', '$sce', '$filter', '$location', function($rootScope, $sce, $filter, $location) {
    var utils = {
        getParameterByName: function (name) {
            //Some magic code below :)
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.hash);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        },
        redirectToUrl: function (url) {
            if(!url) {
                url = $rootScope.server.pageNotFoundUrl;
            }
            window.location.href = url;
        },
        showAjaxLoader: function () {
            $rootScope.showAjaxLoader = true;
        },
        hideAjaxLoader: function () {
            $rootScope.showAjaxLoader = false;
        },
        getProfilePictureUrl: function () {
            return $rootScope.user.profileImageId ? $sce.trustAsResourceUrl($rootScope.server.contextPath + "getFile?id=" + $rootScope.user.profileImageId) : $rootScope.server.contextPath + "/resources/main/img/default_profile_pic.jpg";
        },
        scrollToTop: function () {
            $("html, body").animate({scrollTop: 0}, "slow");
        },
        isAdmin: function () {
            return isAdmin;
        },
        isOperator: function () {
            return isOperator;
        },
        getOrderTypeLabel: function(type) {
            var result;
            switch(type) {
                case 'AC_TECHNICAL':
                    result = 'AC Technical';
                    break;
                default:
                    result = utils.capitalizeFirstLetter(type.toLowerCase());
            }
            return result;
        },
        getOrderStatusLabel: function(status) {
            var result;
            switch(status) {
                case 'TIDYING_UP':
                    result = 'Tidying up';
                    break;
                case 'EN_ROUTE':
                    result = 'En route';
                    break;
                default:
                    result = utils.capitalizeFirstLetter(status.toLowerCase());
            }
            return result;
        },
        capitalizeFirstLetter: function (string) {
            return string.charAt(0).toUpperCase() + string.slice(1);
        }
};
    return utils;
}]);