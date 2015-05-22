### 0.2.1 (2015-05-22)

#### Bug fixes
* fix Atom update problem that Atom doen't update
  v0.2.0 and still use v0.1.0.(#39)
* fix syntax highlight error for ng-options(#20)

### 0.2.0 (2015-02-08)

#### Features
* upgrade to be compatible with atom v1.0 API.
  please see [Upgrading your package to 1.0 APIs]
  (https://atom.io/docs/latest/upgrading/upgrading-your-package) for more details.

#### Bug fixes
* fix syntax highlight error for angular directives

### 0.1.0 (2015-01-02)

#### Features
* add directives and functions for angular v1.3.x
* add syntax highlight for angular directives
  (closes [#13](https://github.com/angular-ui/AngularJS-Atom/issues/13))
* add syntax highlight for angular expressions
  (closes [#18](https://github.com/angular-ui/AngularJS-Atom/issues/18))

### 0.0.5 (2014-09-08)

#### Bug fixes
* remove activation message useless
  (closes [#16](https://github.com/angular-ui/AngularJS-Atom/issues/16))
* remove semicolon in snippets to allow chaining
  (closes [#4](https://github.com/angular-ui/AngularJS-Atom/issues/4))
* fix error in javascript snippets
  (closes [#11](https://github.com/angular-ui/AngularJS-Atom/issues/11),
  thanks to @alepop )

### 0.0.4 (2014-03-03)
merge [atom-angularjs](https://github.com/outsideris/atom-angularjs) package,
thanks to @btesser

#### Features
* support autocompletes in html and javascript
* support snippets in html and javascript

### 0.0.3 (2014-03-01)

#### Bug fixes
* Issue [#2](https://github.com/angular-ui/AngularJS-Atom/pull/2) :
  Improvements to Atom conversion thanks to @stevehansell
    - Replaced $TM_JAVASCRIPT_TERMINATOR with semi-colons
    - Removed escaping on $s in the snippet body
    - Inserted a comma into '.text.html, .meta.tag': to fix the html snippets

### 0.0.2 (2014-02-28)
Updated assets: Add more assets, e.g. keymaps, menus, for more flexibility/options.

### 0.0.1 (2014-02-28)
Initial conversion of textmate version
