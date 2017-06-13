angular.module('jaldi.controllers')
.controller('dashboardController', [
    '$rootScope', '$scope', '$log', '$filter', '$state', 'utils', '$uibModal', 'NgTableParams', 'Dashboard',
    function ($rootScope, $scope, $log, $filter, $state, utils, $uibModal, NgTableParams, Dashboard) {

        $scope.metadata = null;
        $scope.orderByCategory = null;
        $scope.countData = [0, 0, 0, 0, 0, 0, 0];
        $scope.Math = window.Math;

        $scope.pieData = {
            datasets: [{
                data: [],
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

        $scope.loadMetadata = function () {
            Dashboard.overview(function(data) {
                $scope.metadata = data;
            });
            Dashboard.orderByCategory(function(data) {
                $scope.orderByCategory = data;
                for (var i = 0; i < $scope.orderByCategory.length; ++i) {
                    $scope.countData[i] = $scope.orderByCategory[i].count;
                }
                $scope.pieData.datasets[0].data = $scope.countData;
                var ctx = document.getElementById('ordersChartCanvas');
                var chart = new Chart(ctx, {
                    type: 'pie',
                    data: $scope.pieData,
                    options: {
                        responsive: true
                    }
                });
            });
        };

        $scope.loadMetadata();
    }
]);