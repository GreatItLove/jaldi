angular.module('jaldi.controllers')
.controller('ordersController', [
    '$rootScope', '$scope', '$log', '$filter', '$state', 'utils', '$uibModal', 'Order','NgTableParams',
    function ($rootScope, $scope, $log, $filter, $state, utils, $uibModal, Order, NgTableParams) {

        $scope.resultPerPage = 25;
        $scope.tableData = [];
        $scope.filterData = {
            status: 'CREATED',
            type: null
        };
        $scope.selectedItem = null;

        $scope.tableParams = new NgTableParams({
            page: 1,            // show first page
            count: $scope.resultPerPage, // count per page
            sorting: {
                'orderDate': 'asc'     // initial sorting
            }
        }, {
            counts: [],
            total: 0,           // length of data
            getData: function(params) {
                $scope.selectedItem = null;
                return Order.query($scope.filterData).$promise.then(function(data) {
                    console.log(data);
                    params.total(data.length);
                    var orderedData = params.sorting() ? $filter('orderBy')(data, params.orderBy()) : data;
                    $scope.tableData = orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count());
                    return $scope.tableData;
                });
            }
        });

        $scope.selectItem = function(id) {
            $scope.selectedItem = id;
        };

        $scope.reload = function() {
            $scope.tableParams.reload();
        };

    }
]);