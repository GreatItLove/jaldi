angular.module('jaldi.controllers')
.config([
    '$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {
        // $locationProvider.html5Mode(true);
        $stateProvider
            .state('orders', {
                url: '/orders',
                templateUrl: './resources/main/app/orders/orders.html',
                controller: 'ordersController'
            })
            .state('workers', {
                url: '/workers',
                templateUrl: './resources/main/app/workers/workers.html',
                controller: 'workersController'
            })
            .state('profile', {
                url: '/profile',
                templateUrl: './resources/main/app/profile/profile.html',
                controller: 'profileController'
            });
        $urlRouterProvider.otherwise(isAdmin || isOperator ? 'orders' : 'profile');
    }
])
.controller('mainController', [
    '$rootScope', '$scope', '$log', '$filter', '$state', 'utils',
    function ($rootScope, $scope, $log, $filter, $state, utils) {

        /*$scope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams) {
            utils.showAjaxLoader();
        });
        $scope.$on('$stateChangeSuccess', function(event, toState, toParams, fromState, fromParams) {
            utils.hideAjaxLoader();
        });*/
    }
]);