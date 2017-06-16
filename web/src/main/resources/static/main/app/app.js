var jaldi = angular
    .module('jaldi', [
        'ui.router',
        'ui.bootstrap',
        'ui.mask',
        'ngSanitize',
        'ngResource',
        'ngTable',
        'ngImgCrop',
        'jaldi.controllers',
        'jaldi.services',
        'jaldi.directives',
        'jaldi.filters',
        'jaldi.utils'
    ])
    .factory('authHttpResponseInterceptor',['$q','$location',function($q){
        return {
            response: function(response){
                if (response.status === 401) {
                    console.log("Response 401");
                }
                return response || $q.when(response);
            },
            responseError: function(rejection) {
                if (rejection.status === 401) {
                    window.location.reload();
                }
                return $q.reject(rejection);
            }
        }
    }])
    .config(['$httpProvider',function($httpProvider) {
        //Http Intercpetor to check auth failures for xhr requests
        $httpProvider.interceptors.push('authHttpResponseInterceptor');
    }])
    .constant('appConfig', {
        app: {
            commonDateFormat: 'dd.MM.yyyy',
            commonDateTimeFormat: 'dd.MM.yyyy HH:mm',
            commonMomentTimeFormat: 'YYYY-MM-DD HH:mm:ss',
            commonTimeFormat: 'HH:mm'
        },
        roles: {
        },
        user: {
            id: userId,
            userFullName:userFullName,
            profileImageId: profileImageId
        },
        dictionaries: {
            orderStatuses: [{
                name: 'CREATED', label: 'Created'
            }, {
                name: 'CANCELED', label: 'Canceled'
            }, {
                name: null, label: 'All'
            }],
            orderTypes: [{
                name: 'CLEANER', label: 'Cleaner'
            }, {
                name: 'CARPENTER', label: 'Carpenter'
            }, {
                name: 'ELECTRICIAN', label: 'Electrician'
            }, {
                name: 'MASON', label: 'Mason'
            }, {
                name: 'PAINTER', label: 'Painter'
            }, {
                name: 'PLUMBER', label: 'Plumber'
            }, {
                name: 'AC_TECHNICAL', label: 'AC Technical'
            }, {
                name: null, label: 'All'
            }]
        },

        server: {
            rootUrl: 'https://jaldi.pro',
            contextPath: contextPath,
            pageNotFoundUrl: '/404'
        }
    }).run(['$rootScope', '$state', '$stateParams', 'appConfig', 'utils',
        function ($rootScope, $state, $stateParams, appConfig, utils) {
            //Application configuration
            angular.extend($rootScope, appConfig, {
                showAjaxLoader: false,
                utils: utils
            });
            $rootScope.$state = $state;
            $rootScope.$stateParams = $stateParams;
            $rootScope.logout = function() {
                utils.redirectToUrl($rootScope.server.contextPath + '/logout');
            };
        }
    ]);

/*
 * Initialize controllers module
 */
angular.module('jaldi.controllers', []);

/*
 * Initialize services
 */
angular.module('jaldi.services', []);

/*
 * Initialize directives
 */
angular.module('jaldi.directives', []);

/*
 * Initialize filters
 */
angular.module('jaldi.filters',[]);