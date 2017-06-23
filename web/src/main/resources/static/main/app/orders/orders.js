angular.module('jaldi.controllers')
.controller('ordersController', [
    '$rootScope', '$scope', '$log', '$filter', '$state', 'utils', '$uibModal', 'Order','NgTableParams',
    function ($rootScope, $scope, $log, $filter, $state, utils, $uibModal, Order, NgTableParams) {

        $scope.resultPerPage = 25;
        $scope.orderTypes = angular.copy($rootScope.dictionaries.orderTypes);
        $scope.orderTypes.push({
            name: null, label: 'All'
        });
        $scope.tableData = [];
        $scope.filterData = {
            status: 'CREATED',
            type: null
        };
        $scope.selectedItem = null;

        $scope.intervalPromise;
        $scope.init = function() {
            $scope.intervalPromise = setInterval(function(){
                $scope.tableParams.reload();
            }, 60000)
        };
        $scope.init();

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
                    params.total(data.length);
                    var orderedData = params.sorting() ? $filter('orderBy')(data, params.orderBy()) : data;
                    $scope.tableData = orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count());
                    return $scope.tableData;
                });
            }
        });

        $scope.updateOrder = function(selectedItem) {
            var modalTemplate = './resources/main/app/orders/update-order.html?t=' + new Date();
            $uibModal.open({
                windowClass: 'modal',
                templateUrl: modalTemplate,
                backdrop: 'static',
                controller: function($scope, $uibModalInstance) {
                    $scope.orderData = {};
                    var order = new Order({id:selectedItem});
                    order.$get({},function(data){
                        $scope.orderData = data;
                        $scope.orderData.dateTimeLocal = new Date($scope.orderData.orderDate);
                    }, function(failedResponse){
                        //on failure
                    });
                    $scope.cancel = function() {
                        $uibModalInstance.dismiss();
                    };
                    $scope.save = function() {
                        if ($scope.orderForm.$invalid) {
                            $scope.submitted = true;
                            return;
                        }
                        var submitData = $scope.orderData;
                        submitData.orderDate = new Date($scope.orderData.dateTimeLocal).getTime();
                        submitData.formattedOrderDate = undefined;
                        console.log(submitData);
                        var order = new Order(submitData);
                        order.$update({id:selectedItem}, function () {
                            $uibModalInstance.close('success');
                        }, function (failedResponse) {
                            //on failure
                        });
                    };
                }
            }).result.then(function(result) {
                if(result == 'success') {
                    $scope.tableParams.reload();
                }
            }, function() {
                console.log('Unable to create/update worker');
            });
        };

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

        $scope.showWarning = function(item) {
            //less than 1 hour left
            return new Date().getTime() + 3600 * 1000 > item.orderDate && item.status == 'CREATED';
        };

        $scope.showDanger = function(item) {
            //less than 30 minutes left
            return new Date().getTime() + 1800 * 1000 > item.orderDate && item.status == 'CREATED';
        };

        $scope.$on('$destroy',function(){
            if($scope.intervalPromise)
                clearInterval($scope.intervalPromise);
        });
    }
]);