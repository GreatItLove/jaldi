angular.module('jaldi.controllers')
.controller('dashboardController', [
    '$rootScope', '$scope', '$log', '$filter', '$state', 'utils', '$uibModal', 'NgTableParams', 'Dashboard',
    function ($rootScope, $scope, $log, $filter, $state, utils, $uibModal, NgTableParams, Dashboard) {

        $scope.metadata = null;
        $scope.Math = window.Math;
        $scope.loadMetadata = function () {
            Dashboard.overview(function(data) {
                $scope.metadata = data;
            });
        };

        $scope.loadMetadata();

        var pieData = {
            datasets: [{
                data: [
                    210,
                    20,
                    17,
                    15,
                    12,
                    10,
                    9

                ],
                backgroundColor: [
                    '#73d161',
                    '#006bb9',
                    '#ffb600',
                    '#a53606',
                    '#993158',
                    '#43b1d1',
                    '#09c6b9'
                ]
            }],
            labels: [
                'Cleaner',
                'Carpenter',
                'Electrician',
                'Mason',
                'Painter',
                'Plumber',
                'AC Technical'
            ]
        };
        var ctx = document.getElementById('ordersChartCanvas');
        var chart = new Chart(ctx, {
            type: 'pie',
            data: pieData,
            options: {
                responsive: true
            }
        });
    }
]);