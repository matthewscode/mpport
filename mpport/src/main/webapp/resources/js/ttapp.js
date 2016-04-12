var ttApp = angular.module('ttApp', ['textAngular']);

ttApp.directive('ckEditor', [function () {
    return {
        require: '?ngModel',
        link: function ($scope, elm, attr, ngModel) {
        	   var config = {
                       toolbar:[[ 'Bold', 'Italic', 'Underline', 'Strike', 'TextColor', 'FontSize', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight' ]],
                       width: '100%',
                       height: '30.00vh',
                       autoParagraph: false
                   };
            var ck = CKEDITOR.replace(elm[0], config);

            ck.on('change', function () {
                $scope.$apply(function () {
                    ngModel.$setViewValue(ck.getData());
                });
            });

            ngModel.$render = function (value) {
                ck.setData(ngModel.$modelValue);
            };
        }
    };
}])

ttApp.controller('ApiController', ['$scope', '$http', '$location', function($scope, $http, $location) {
	var tokenUrl;
	var host = $location.host();
	host = location.host;
	var protocol = $location.protocol();
	host = protocol + '://' +  host;
	$scope.loading = true;
	$scope.token;
	var processData = function(data) {
		// Sort
		if($scope.options.sort && data) {
			data = _.sortBy(data, $scope.options.sort);
			if($scope.options.sortDirection && $scope.options.sortDirection === 'descending') {
				$scope.options.reverse();
			}
		}		
		return data;
	};
	$scope.getToken = function(callback){
		$http.get(host + $scope.tokenUrl)
		.success(function(data, status, headers, config) {
				if(typeof callback === 'function'){
					callback(data.token);
				}
				return data.token;
		    }) .error(function(data, status, headers, config) {
		    	console.log('woops error');
		    });
	}
		
	$scope.init = function(url, tokenUrl, options) {
		if(!url) {
			return;
		}
		$scope.tokenUrl = tokenUrl;
		$scope.dataUrl = url;
		$scope.options = options || {};
		$scope.options.start = $scope.options.start || 0;
		$scope.options.amount = $scope.options.amount || 50;
		var initializeData = function(token){
			var initToken = '?token=' + token;
			console.log('url to get to ' + url + initToken);
		$http.get(url + initToken)
			.success(function(data, status, headers, config) {
				$scope.loading = false;
				$scope.data = processData(data);
				$scope.nextStart = 25;
				if($scope.options.callback && typeof $scope.options.callback === 'function') {
					$scope.options.callback.apply(null, [$scope.data]);
				}
		    })
		    .error(function(data, status, headers, config) {
		    	$scope.data = {error: true};
		    });
		}
		$scope.getToken(initializeData);
		
	};
	
	$scope.loadMore = function(url, increment) {
		console.log('loading');
		if(increment){
			$scope.increment = increment
		}else{
			$scope.increment = 25;
		}
		$scope.nextEnd = $scope.nextStart + $scope.increment;
		url = url +  '/api/ft/start/' +$scope.nextStart + '/end/' + $scope.nextEnd;
		$scope.nextStart = $scope.nextEnd + 1;
		$scope.nextEnd = $scope.nextStart + $scope.increment;
		
		var loadMoreResults = function(token){
			var loadMoreToken = '?token=' + token;
		$http.get(url + loadMoreToken)
			.success(function(data, status, headers, config) {
				$scope.data = $scope.data.concat(processData(data));
				$scope.options.start += $scope.options.amount;
			})
		    .error(function(data, status, headers, config) {
	    		 console.log('errored')
		    });
		}
		$scope.getToken(loadMoreResults);
	};
	
}]);

ttApp.controller('FileController', ['$scope', '$http', function($scope, $http) {
	$scope.showEditor = false;
	$scope.showAdminMenu = false;
	$scope.editorLoading = false;
	$scope.assignedImages =[];
	$scope.currentFile = { };
	$scope.setEditor = function(url, checksumId, imgUrl, model){
		if($scope.showAdminMenu){
			var addToArray=true;
			for(var i=0;i<$scope.assignedImages.length;i++){
			    if($scope.assignedImages[i] === imgUrl){
			        addToArray=false;
			    }
			}
			if(addToArray){
				$scope.assignedImages.push(imgUrl);
			}
		}else{
		$scope.showEditor = true;
		$scope.editorLoading = true;
		$scope.currentFile = model;
		var fullUrl = url + checksumId;
		
		var populateEditor = function(token){
			var editorToken = '?token=' + token;
			$http.get(fullUrl + editorToken).success(function(data, status, headers, config) {
				$scope.editorLoading = false;
				$scope.imgUrl = imgUrl;
				$scope.checksumId = data.checksumId;
				$scope.transcriptionId = data.transcriptionId;
				$scope.transcriptionText = data.transcriptionText;
				$scope.transcriptionWordCount = data.transcriptionWordCount;
				$scope.translationId = data.translationId;
				$scope.translationText = data.translationText;
				$scope.translationWordCount = data.translationWordCount;
			})
			 .error(function(data, status, headers, config) {
	    		 console.log('lol u errored')
		    });
		}
		$scope.getToken(populateEditor);
	}
	}
	$scope.submitTranscription = function(url, transcriptionId, text, cid){
		$scope.dataUrl = url;
		$scope.options = {};
		var data = {
				id: transcriptionId,
				imageChecksum: {id: cid},
				transcriptionText: text
		};
		var postTranscription = function(token){
			var fullToken = '?token=' + token;
			$http.post(url + fullToken, data)
			.success(function(data, status, headers, config) {
				$scope.currentFile.hasTranscription = true;
				$scope.checksumId = data.checksumId;
				$scope.transcriptionId = data.transcriptionId;
				$scope.transcriptionText = data.transcriptionText;
				$scope.transcriptionWordCount = data.transcriptionWordCount;
				if(data.imageTranslationList != null && data.imageTranslationList[0].translationText > 0){
					$scope.translationId = data.imageTranslationList[0].id;
					$scope.translationText = data.imageTranslationList[0].translationText;
					$scope.translationNoWords = data.imageTranslationList[0].translationNoWords;
				}
			})
		    .error(function(data, status, headers, config) {
	    		 console.log('lol u errored')
		    });
		}
		$scope.getToken(postTranscription);
	}
	$scope.submitTranslation = function(url, text, tid){
		var data = {
				imageTranscription: {id: tid},
				translationText: text
		};
	var postTranslation = function(token) {
		var fullToken = '?token=' + token;
		$http.post(url + fullToken, data)
		.success(function(data, status, headers, config) {
			$scope.currentFile.hasTranslation= true;
			$scope.translationId = data.translationId;
			$scope.translationText = data.translationText;
			$scope.translationWordCount = data.translationWordCount;
		})
	    .error(function(data, status, headers, config) {
    		 console.log('lol u errored')
	    });
		}
		$scope.getToken(postTranslation);
		
	}
	
	$scope.enableAdminMenu = function(){
		$scope.showAdminMenu = !$scope.showAdminMenu;
	}
	
	$scope.removeImageUrl = function(imageUrl){
		var imgIndex = $scope.assignedImages.indexOf(imageUrl);
		$scope.assignedImages.splice(imgIndex, 1);
	}
}]);

ttApp.controller('utilController', ['$scope', '$http', function($scope, $http) {
	
	$scope.submitImageChecksum = function(url){
		$http.get(url).success(function(){
			console.log('made it');
		});
		}
	$scope.submitFileTranslation = function(url, originUrl){
		var newUrl = url + encodeURIComponent(originUrl);
		$http.get(newUrl).success(function(){
			console.log('made it');
		});
		}
	
}]);
