angular.module('jaldi.controllers')
.controller('workersController', [
    '$rootScope', '$scope', '$log', '$filter', '$state', 'utils', '$uibModal', 'Worker','NgTableParams',
    function ($rootScope, $scope, $log, $filter, $state, utils, $uibModal, Worker, NgTableParams) {

        $scope.resultPerPage = 10;
        $scope.tableData = [];
        $scope.selectedItem = null;

        $scope.tableParams = new NgTableParams({
            page: 1,            // show first page
            count: $scope.resultPerPage, // count per page
            sorting: {
                'user.name': 'asc'     // initial sorting
            }
        }, {
            counts: [],
            total: 0,           // length of data
            getData: function(params) {
                $scope.selectedItem = null;
                return Worker.query().$promise.then(function(data) {
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

        $scope.addEditWorker = function(selectedItem) {
            var modalTemplate = './resources/main/app/workers/add-edit-workers.html?t=' + new Date();
            $uibModal.open({
                windowClass: 'modal',
                templateUrl: modalTemplate,
                backdrop: 'static',
                controller: function($scope, $uibModalInstance) {
                    $scope.workerData = {
                        user : {
                            active:true,
                            password: Math.random().toString(36).slice(-8)
                        }
                    };
                    if(selectedItem) {
                        $scope.isEdit = true;
                        var worker = new Worker({id:selectedItem});
                        worker.$get({},function(data){
                            $scope.workerData = data;
                        }, function(failedResponse){
                            //on failure
                        });
                    }
                    $scope.cancel = function() {
                        $uibModalInstance.dismiss();
                    };
                    $scope.save = function() {
                        if($scope.workerForm.$invalid) {
                            $scope.submitted = true;
                            return;
                        }
                        var worker = new Worker($scope.workerData);
                        if(selectedItem) {
                            worker.$update({id:selectedItem}, function () {
                                $uibModalInstance.close('success');
                            }, function (failedResponse) {
                                //on failure
                            });
                        } else {
                            worker.$save({}, function () {
                                $uibModalInstance.close('success');
                            }, function (failedResponse) {
                                //on failure
                            });
                        }
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

        $scope.deleteWorker = function(id) {
            var modalTemplate = './resources/main/app/workers/delete-worker.html?t=' + new Date();
            $uibModal.open({
                windowClass: 'modal',
                templateUrl: modalTemplate,
                backdrop: 'static',
                size: '400',
                controller: function($scope, $uibModalInstance, worker) {
                    $scope.worker = worker;
                    $scope.cancel = function() {
                        $uibModalInstance.dismiss();
                    };
                    $scope.delete = function() {
                        utils.showAjaxLoader();
                        var worker = new Worker({id:id});
                        worker.$delete({},function(response){
                            $uibModalInstance.close('success');
                        }, function(failedResponse){
                            //on failure
                        });
                    };
                },
                resolve: {
                    worker: function() {
                        return $.grep($scope.tableData, function(e) {
                            return (e.user.id == id)
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
    }
]);