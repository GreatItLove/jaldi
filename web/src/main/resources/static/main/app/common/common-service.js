angular.module('jaldi.services')
.factory("Profile", function ($resource) {
    return $resource("/rest/profile/:id", {id: "@id"}, {
        update: {
            method: 'PUT'
        },
        changePassword: {
            method: 'POST',
            url:    '/rest/profile/changePassword'
        },
        updateProfilePicture: {
            method: 'POST',
            url:    '/rest/profile/updateProfilePicture'
        }
    });
})
.factory("Worker", function ($resource) {
    return $resource("/rest/worker/:id", {id: "@id"}, {
        update: {
            method: 'PUT'
        }
    });
})
.factory("Order", function ($resource) {
    return $resource("/rest/order/:id", {id: "@id"}, {
        update: {
            method: 'PUT'
        }
    });
})
.factory("Dashboard", function ($resource) {
    return $resource("/rest/dashboard/:id", {id: "@id"}, {
        overview: {
            method: 'GET',
            url:    '/rest/dashboard/overview'
        },
    });
});