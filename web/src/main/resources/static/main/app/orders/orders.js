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
                'creationDate': 'desc'     // initial sorting
            }
        }, {
            counts: [],
            total: 0,           // length of data
            getData: function(params) {
                $scope.selectedItem = null;
                return Order.query($scope.filterData).$promise.then(function(data) {
                    params.total(data.length);
                    var orderedData = params.sorting() ? $filter('orderBy')(data, params.orderBy()) : data;
                    $scope.tableData = orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count());
                    return $scope.tableData;
                });
            }
        });

        $scope.cancelOrder = function(id) {
            var modalTemplate = './resources/main/app/orders/cancel-order.html?t=' + new Date();
            $uibModal.open({
                windowClass: 'modal',
                templateUrl: modalTemplate,
                backdrop: 'static',
                size: '400',
                controller: function($scope, $uibModalInstance, order) {
                    $scope.order = order;
                    $scope.cancel = function() {
                        $uibModalInstance.dismiss();
                    };
                    $scope.cancelOrder = function() {
                        utils.showAjaxLoader();
                        var order = new Order({orderId:id, status:'CANCELED'});
                        order.$updateStatus({}, function(response){
                            $uibModalInstance.close('success');
                        }, function(failedResponse){
                            //on failure
                        });
                    };
                },
                resolve: {
                    order: function() {
                        return $.grep($scope.tableData, function(e) {
                            return (e.id == id)
                        })[0];
                    }
                }
            }).result.then(function(result) {
                if(result == 'success') {
                    $scope.tableParams.reload();
                }
            }, function() {
                console.log('Unable to delete worker');
            });
        };

        $scope.selectItem = function(id) {
            $scope.selectedItem = id;
        };

        $scope.reload = function() {
            $scope.tableParams.reload();
        };

    }
]);