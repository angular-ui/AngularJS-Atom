# AngularJS support in Atom

Adds syntax highlighting and snippets to AngularJS in Atom.

Originally [converted](http://atom.io/docs/latest/converting-a-text-mate-bundle)
from the [AngularJS TextMate bundle](https://github.com/angular-ui/AngularJs.tmbundle).

Contributions are greatly appreciated. Please fork this repository and open a
pull request to add snippets, make grammar tweaks, etc.

## Supported features

### Autocompletes

You can use autocompletes for directives in HTML and
angular.js's variables and function in JavaScript.
See [settings](https://github.com/angular-ui/AngularJS-Atom/blob/master/settings/)
for more details.

![](https://raw.github.com/angular-ui/AngularJS-Atom/master/screenshots/autocompletes.gif)

If you type some prefix and press `ctrl` + `space`,
you can use autocompletes in below.

#### HTML
```
ng-valid
ng-invalid
ng-pristine
ng-dirty
ng-show
ng-required
ng-minlength
ng-maxlength
ng-pattern
ng-true-value
ng-false-value
ng-value
ng-trim
ng-app
ng-bind
ng-bind-html
ng-bind-template
ng-blur
ng-change
ng-checked
ng-class
ng-class-even
ng-class-odd
ng-click
ng-cloak
ng-controller
ng-copy
ng-csp
ng-cut
ng-dblclick
ng-disabled
ng-focus
ng-form
ng-hide
ng-href
ng-if
ng-include
ng-init
ng-keydown
ng-keypress
ng-keyup
ng-list
ng-model
ng-model-options
ng-mousedown
ng-mouseenter
ng-mouseleave
ng-mousemove
ng-mouseover
ng-mouseup
ng-non-bindable
ng-open
ng-paste
ng-pluralize
ng-readonly
ng-repeat
ng-repeat-start
ng-repeat-end
ng-selected
ng-src
ng-srcset
ng-style
ng-submit
ng-switch
ng-options
ng-switch-when
ng-switch-default
ng-transclude
ng-view
ng-messages
ng-message
ng-swipe-left
ng-swipe-right
```

#### JavaScript

```
angular
bind
bootstrap
copy
element
equals
extend
forEach
fromJson
identity
injector
isArray
isDate
isDefined
isElement
isFunction
isNumber
isObject
isString
isUndefined
lowercase
module
noop
reloadWithDebugInfo
toJson
uppercase
$anchorScroll
$animate
$cacheFactory
$compile
$controller
$document
$exceptionHandler
$filter
$http
$httpBackend
$interpolate
$interval
$locale
$location
$log
$parse
$q
$rootElement
$rootScope
$sce
$sceDelegate
$templateCache
$templateRequest
$timeout
$window
$animateProvider
$compileProvider
$controllerProvider
$filterProvider
$httpProvider
$interpolateProvider
$locationProvider
$logProvider
$parseProvider
$rootScopeProvider
$sceDelegateProvider
$sceProvider
$injector
$provide
$ariaProvider
$aria
$cookieStore
$cookies
mock
$exceptionHandlerProvider
TzDate
dump
inject
$resource
$routeProvider
$route
$routeParams
$sanitize
$swipe
controller
$scope
service
factory
provider
ngResource
defer
config
when
otherwise
directive
run
filter
```

### Snippets

You can use snippets in HTML and JavaScript.
See [snippets](https://github.com/angular-ui/AngularJS-Atom/tree/master/snippets)
for more details.

![](https://raw.github.com/angular-ui/AngularJS-Atom/master/screenshots/snippets.gif)

If you type prefix and press `tab`,
It will be replaced by snippet for it.

#### HTML

##### ngindex
```
<html>
<head>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/$1/angular.js"></script>
</head>
<body ng-app>
 $2
</body>
</html>
```

##### ngsa
```
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/angularjs/$1/angular.js"></script>
```

##### ngst
```
<script type="text/ng-template" id="$1">
  $2
</script>
```

##### nginc
```
<ng-include src="$1" ${2: onload="$3"} ${4: autoscroll="$5"}></ng-include>
```

##### ngplural
```
<ng-pluralize count="$1" when="$2" ${3: offset="$4"}></ng-pluralize>
```

##### ngswitch
```
<ng-switch on="$1">$2</ng-switch>
```

##### ngtmpl
```
<script type="text/ng-template">$1</script>
```

##### ngview
```
<ng-view ${1: onload="$2"} ${3: $autoscroll="$4"}></ng-view>
```

#### JavaScript

##### ngm
```
angular.module('$1', [$2])$3
```

##### ngma
```
var $1 = angular.module('$2', [$3])$4
```

##### ngmc
```
var $1 = angular.module('$2', [$3], function($4) {
    $5
})$6
```

##### ngmfa
```
factory('$1', function($2) {
  $3
})$4
```

##### ngmfi
```
filter('$1', function($2) {
  return function (input, $3) {
    $4
  };
})$5
```

##### ngms
```
service('$1', function($2) {
  $3
})$4
```

##### ngro
```
$routeProvider.otherwise({redirectTo: '$1' });
```

##### ngrw
```
$routeProvider.when('$1', {templateUrl: '$2', controller: '$3'});
```

##### ngrwr
```
$routeProvider.when('$1', {templateUrl: '$2', controller: '$3', resolve: {$4} });
```

##### ngfor
```
angular.forEach($1, function(value, key) {
  $2
});
```

##### ngdl
```
.directive('$1', function($2) {
  $3
  return function(scope, element, attrs) {
    $4
  }
})$5
```

##### ngdlf
```
function (scope, element, attrs) {
  $1
}
```

##### ngdc
```
.directive('$1', function factory($2) {
  var directiveDefinitionObject = {
    $3
    compile: function compile(tElement, tAttrs, transclude) {
      $4
      return function (scope, element, attrs) {
        $5
      }
    }
  };
  return directiveDefinitionObject;
})$6
```

##### ngdcf
```
function compile(tElement, tAttrs, transclude) {
  $1
  return function (scope, element, attrs) {
    $2
  }
}$3
```

##### ngb
```
$scope.$broadcast('$1', $2);
```

##### nge
```
$scope.$emit('', );
```

##### ngf
```
$scope.$1 = function($2) {
  $3
};
```

##### ngcp
```
$1Ctrl.prototype.$2 = function $2($3) {
  $4
};
```

##### ngon
```
$scope.$on('$1', function(event, $2) {
  $3
});
```

##### ngv
```
$scope.$1 = $2;
```

##### ngw
```
$scope.$watch('$1', function(newValue, oldValue) {
  $2
});
```

##### ngc
```
var $1 = function($scope, $2) {
  $3
}
```

##### ngc$
```
$1Ctrl.$inject = [$scope, '$2'];
function $1Ctrl($scope, $2) {
  $4
}
angular.module($3).controller('$1Ctrl', $1Ctrl);
```

##### ngdoc
```
/**
 * @ngdoc ${1:function}
 * @name $2
 * @description
 * $3
 * 
 */
```

##### nghttp
```
$http({method: '${1:GET}', url: '$2'})
.success(function(data, status, headers, config) {
  $3
})
.error(function(data, status, headers, config) {
  $4
});
```

##### ngcopy
```
angular.copy(${1:source} ${2:, ${3:destination}})
```

##### ngel
```
angular.element(${1:element});
```

##### ngeq
```
angular.equals(${1:object1}, ${2:object2});
```

##### ngext
```
angular.extend(${1:destinationObject}, ${2:sourceObject})
```

##### ngisa
```
angular.isArray(${1:value})
```

##### ngisd
```
angular.isDefined(${1:value})
```

##### ngisf
```
angular.isFunction(${1:value})
```

##### ngisn
```
angular.isNumber(${1:value})
```

##### ngiso
```
angular.isObject(${1:value})
```

##### ngiss
```
angular.isString(${1:value})
```


##### nglo
```
angular.lowercase(${1:string});
```

##### ngup
```
angular.uppercase(${1:string});
```
