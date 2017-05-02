angular.module('jaldi.filters')
.filter('utcToBrowserDate', [ '$rootScope', function($rootScope) {
    return function(milis) {
        return milis && moment(moment.utc(milis)).local().format($rootScope.app.commonMomentTimeFormat);
    };
}])
.filter('toTextDate', [ '$rootScope', function($rootScope) {
    return function(milis) {
        return milis && moment(moment.utc(milis)).local().calendar(null, {
                lastDay : '[Yesterday at] HH:mm',
                sameDay : '[Today at] HH:mm',
                nextDay : '[Tomorrow at] HH:mm',
                lastWeek : '[last] dddd [at] HH:mm',
                nextWeek : 'dddd [at] HH:mm',
                sameElse : 'HH:mm'
            });
    };
}]);