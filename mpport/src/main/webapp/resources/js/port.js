var portApp = angular.module('portApp', ['chart.js']);

portApp.controller("DoughnutCtrl", function ($scope) {
	  $scope.labels = ["Completed", "Returned"];
	  $scope.data = [85,11];
	  $scope.fullData = $scope.clientDonut;
	  $scope.$on('donutDataChange', function(event, newData) {
			console.log('inside' + newData);
			  $scope.fullData = newData;
			  $scope.data = newData[0];
		});
	  $scope.allTime = function(){
		  $scope.data = $scope.fullData[1];
	  }
	  $scope.twoWeeks = function(){
		  $scope.data = $scope.fullData[0];
	  }
	});

portApp.controller("LineCtrl", function ($scope) {
	$scope.$on('lineDataChange', function(event, newData) {
		console.log('inside' + newData);
		$scope.data = newData;
	});
	  $scope.labels = ["January", "February", "March", "April", "May", "June", "July"];
	  $scope.series = ['Series A', 'Series B', 'Series C', 'Series D'];
	  $scope.data = $scope.clientData;
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
		$scope.clientName = 'Tesla';
		$scope.clientLogo = 'resources/images/logos/tesla.png';
		$scope.imageNum = '#73';
		$scope.segOne = '#3328';
		$scope.segTwo = '#3325';
		$scope.segThree = '#1117';
		$scope.switchClient = function(client){
			if(client == 'tesla'){
				$scope.$broadcast('lineDataChange', $scope.teslaData);
				$scope.$broadcast('donutDataChange', $scope.teslaDonut);
				$scope.clientName = 'Tesla';
				$scope.clientLogo = 'resources/images/logos/tesla.png';
				$scope.imageNum = '#73';
				$scope.segOne = '#3328';
				$scope.segTwo = '#3325';
				$scope.segThree = '#1117';
			}
			if(client == 'zen'){
				$scope.$broadcast('lineDataChange', $scope.zenData);
				$scope.$broadcast('donutDataChange', $scope.zenDonut);
				$scope.clientName = 'Zen Pencils';
				$scope.clientLogo = 'resources/images/logos/zen-pencils.png';
				$scope.imageNum = '#21';
				$scope.segOne = '#278';
				$scope.segTwo = '#279';
				$scope.segThree = '#255';
			}
			if(client == 'mizuno'){
				$scope.$broadcast('lineDataChange', $scope.mizunoData);
				$scope.$broadcast('donutDataChange', $scope.mizunoDonut);
				$scope.clientName = 'Mizuno Golf';
				$scope.clientLogo = 'resources/images/logos/mizuno-golf.png';
				$scope.imageNum = '#10';
				$scope.segOne = '#18';
				$scope.segTwo = '#19';
				$scope.segThree = '#11';
			}
		}
		$scope.teslaData = [
		            	    [55],
		            	    [],
		            	    [61, 59, 80, 81, 68, 69, 87],
		            	    [55, 56, 58, 70, 60, 63, 70]
		            	  ];
		$scope.teslaDonut = [[85,11],[3351,29]];
		$scope.zenDonut = [[22,1],[56,10]];
		$scope.zenData = [
		            	    [90],
		            	    [],
		            	    [89, 88, 93, 92, 93, 92, 93],
		            	    [90, 89, 95, 93, 94, 93, 95]
		            	  ];
		$scope.mizunoDonut = [[10,0],[120,3]];
		$scope.mizunoData = [
			            	    [18],
			            	    [],
			            	    [17, 19, 25, 19, 17, 21, 22],
			            	    [18, 18, 22, 22, 18, 18, 22]
			            	  ];
		$scope.clientData = $scope.teslaData;
		$scope.clientDonut = $scope.teslaDonut;
		
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

