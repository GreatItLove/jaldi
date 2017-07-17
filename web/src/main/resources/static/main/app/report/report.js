angular.module('jaldi.controllers')
    .controller('reportController', [
        '$rootScope', '$scope', '$log', '$filter', '$state', 'utils', '$uibModal', 'NgTableParams', 'Report',
        function ($rootScope, $scope, $log, $filter, $state, utils, $uibModal, NgTableParams, Report) {

            $scope.workersReport = null;
            $scope.resultPerPage = 5;
            $scope.currentDate = new Date();

            $scope.tableParams = new NgTableParams({
                page: 1,            // show first page
                count: $scope.resultPerPage, // count per page
                sorting: {
                    'name': 'asc'     // initial sorting
                }
            }, {
                counts: [],
                total: 0,           // length of data
                getData: function(params) {
                    var requestData = {
                        fromDate: $filter('date')($scope.report.fromDate, $rootScope.app.commonDateFormatSql),
                        toDate: $filter('date')($scope.report.toDate, $rootScope.app.commonDateFormatSql)
                    };
                    Report.workersReport(requestData,function(data) {
                        var orderedData = params.sorting() ? $filter('orderBy')(data, params.orderBy()) : data;
                        params.data = orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count());
                        params.total(data.length);
                    });
                }
            });

            $scope.loadMetadata = function () {
                $scope.tableParams.reload();
            };

            $scope.report = {
                toDate: new Date(),
                fromDate: new Date($scope.currentDate.setMonth($scope.currentDate.getMonth() - 1))
            };

        }
    ]);