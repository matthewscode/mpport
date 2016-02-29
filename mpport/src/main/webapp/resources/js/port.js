var portApp = angular.module('portApp', ['chart.js']);

portApp.controller("DoughnutCtrl", function ($scope) {
	  $scope.labels = ["Completed", "Returned"];
	  $scope.data = [85,2];
	  
	  $scope.allTime = function(){
		  $scope.data = [3331, 25];
	  }
	  $scope.twoWeeks = function(){
		  $scope.data = [85, 2];
	  }
	});

portApp.controller("LineCtrl", function ($scope) {

	  $scope.labels = ["January", "February", "March", "April", "May", "June", "July"];
	  $scope.series = ['Translated', 'Total'];
	  $scope.data = [
	    [0, 1100, 2000, 3350, 3412, 3856, 4212],
	    [2300, 2100, 3300, 3820, 3810, 4200, 4212]
	  ];
	  $scope.onClick = function (points, evt) {
	    console.log(points, evt);
	  };
	});

portApp.controller('portController', ['$scope', '$http', function($scope, $http) {
	
	$scope.init = function(url) {
		if(!url) {
			return;
		}
		$scope.dataUrl = url;
		
		$http.get(url)
			.success(function(data, status, headers, config) {
				$scope.data = data;
		    })
		    .error(function(data, status, headers, config) {
		    	$scope.data = {error: true};
		    });
	};
	
	$scope.loadMore = function(increment) {
		console.log('loading');
		if(increment){
			$scope.increment = increment
		}else{
			$scope.increment = 25;
		}
		$scope.nextEnd = $scope.nextStart + $scope.increment;
		url = 'api/ft/start/' +$scope.nextStart + '/end/' + $scope.nextEnd;
		$scope.nextStart = $scope.nextEnd + 1;
		$scope.nextEnd = $scope.nextStart + $scope.increment;
		$http.get(url)
			.success(function(data, status, headers, config) {
				$scope.data = $scope.data.concat(processData(data));
				$scope.options.start += $scope.options.amount;
			})
		    .error(function(data, status, headers, config) {
	    		 console.log('lol u errored')
		    });
		
	};
	
}]);

portApp.controller('FileController', ['$scope', '$http', function($scope, $http) {
	$scope.showEditor = false;
	$scope.currentFile = { };
	$scope.setEditor = function(url, checksumId, imgUrl, model){
		$scope.currentFile = model;
		var fullUrl = url + checksumId;
		$http.get(fullUrl).success(function(data, status, headers, config) {
			$scope.showEditor = true;
			$scope.imgUrl = imgUrl;
			$scope.checksumId = data.checksumId;
			$scope.transcriptionId = data.transcriptionId;
			$scope.transcriptionText = data.transcriptionText;
			$scope.transcriptionWordCount = data.transcriptionWordCount;
			$scope.translationId = data.translationId;
			$scope.translationText = data.translationText;
			$scope.translationWordCount = data.translationWordCount;
			console.log('yay');
			console.log(data);
		})
		 .error(function(data, status, headers, config) {
    		 console.log('lol u errored')
	    });
	}
	$scope.submitTranscription = function(url, transcriptionId, text, cid){
		console.log('test: ' +cid);
		var data = {
				id: transcriptionId,
				imageChecksum: {id: cid},
				transcriptionText: text
		};
		$http.post(url, data)
		.success(function(data, status, headers, config) {
			$scope.currentFile.hasTranscription = true;
			$scope.checksumId = data.checksumId;
			$scope.transcriptionId = data.transcriptionId;
			$scope.transcriptionText = data.transcriptionText;
			$scope.transcriptionWordCount = data.transcriptionWordCount;
			console.log($scope.data);
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
	$scope.submitTranslation = function(url, text, tid){
		var data = {
				imageTranscription: {id: tid},
				translationText: text
		};
		$http.post(url, data)
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
}]);

portApp.controller('utilController', ['$scope', '$http', function($scope, $http) {
	
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

