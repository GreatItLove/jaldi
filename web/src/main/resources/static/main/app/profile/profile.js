angular.module('jaldi.controllers')
.controller('profileController', [
    '$rootScope', '$scope', '$log', '$filter', '$state', 'utils', '$uibModal', 'Profile',
    function ($rootScope, $scope, $log, $filter, $state, utils, $uibModal, Profile) {

        $scope.alerts = [];
        $scope.userData = {};
        $scope.pass = {};

        var controller = this;
        this.loadProfile = function() {
            var profile = new Profile({id:$rootScope.user.id});
            profile.$get({},function(data){
                $scope.userData = data;
            }, function(failedResponse){

            });
        };
        this.loadProfile();

        $scope.updateProfile = function() {
            var profile = new Profile($scope.userData);
            profile.$update({},function(data){
                $scope.userData = data;
                $rootScope.user.userFullName = data.name;
                $scope.alerts = [];
                $scope.alerts.push({type: 'info', msg: "Profile successfully updated."});
                utils.scrollToTop();
            }, function(failedResponse){
                console.log(failedResponse);
            });
        };

        $scope.changePassword = function() {
            var profile = new Profile($scope.pass);
            profile.$changePassword({},function(data){
                $scope.alerts = [];
                $scope.alerts.push({type: 'info', msg: "Profile password successfully changed."});
                $scope.pass = {};
                utils.scrollToTop();
            }, function(failedResponse){
                $scope.alerts = [];
                $scope.alerts.push({type: 'error', msg: "The old password is incorrect."});
                $scope.pass = {};
                utils.scrollToTop();
                console.log(failedResponse);
            });
        };

        $scope.closeMe = function(index) {
            $scope.alerts.splice(index, 1);
        };

        $scope.myImage='';
        var handleFileSelect=function(evt) {
            var file=evt.currentTarget.files[0];
            var reader = new FileReader();
            reader.onload = function (evt) {
                $scope.$apply(function($scope){
                    $scope.myImage=evt.target.result;
                    $scope.changeProfilePicture();
                });
            };
            if(file) {
                reader.readAsDataURL(file);
            }
        };
        angular.element(document.querySelector('#inputImage')).on('change', handleFileSelect);

        $scope.changeProfilePicture = function() {
            var modalTemplate = './resources/main/app/profile/uploadPicture.html?t=' + new Date();
            $uibModal.open({
                windowClass: 'modal',
                templateUrl: modalTemplate,
                backdrop: 'static',
                controller: function($scope, $uibModalInstance, myImage) {
                    $scope.myImage = myImage;
                    $scope.myCroppedImage='';

                    $scope.cancel = function() {
                        $uibModalInstance.dismiss();
                    };
                    $scope.upload = function() {
                        var changeProfilePictureReq = {
                            id: $rootScope.user.id,
                            profileImageBase64: $scope.myCroppedImage.replace(/^data:image\/(png|jpg);base64,/, "")
                        };
                        var profile = new Profile(changeProfilePictureReq);
                        profile.$updateProfilePicture({},function(data) {
                            if(data) {
                                $rootScope.user.profileImageId = data.profileImageId;
                            }
                            $uibModalInstance.close('success');
                        }, function(failedResponse){
                        });
                    };
                },
                resolve: {
                    myImage: function() {
                        return $scope.myImage;
                    }
                }
            }).result.then(function(result) {
                if(result == 'success') {
                    controller.loadProfile();
                }
            }, function() {
                console.log('Unable to upload profile picture.');
            });
        };
    }
]);