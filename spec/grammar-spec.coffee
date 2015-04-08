describe 'directive grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('angularjs')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.html.angular')

  it 'parses the grammar', ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe 'text.html.angular'

  describe 'directive attributes', ->
    it 'tokenizes ng-repeat attribute inside HTML', ->
      lines = grammar.tokenizeLines '''
        <dd ng-repeat="availability in phone.availability">{{availability}}</dd>
      '''

      expect(lines[0][3]).toEqual value: 'ng-repeat', scopes: ['text.html.angular', 'meta.tag.block.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']

    it 'tokenizes ng-src and ng-click attributes inside HTML', ->
      lines = grammar.tokenizeLines '''
        <li ng-repeat="img in phone.images">
          <img ng-src="{{img}}" ng-click="setImage(img)">
        </li>
      '''

      expect(lines[0][3]).toEqual value: 'ng-repeat', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']
      expect(lines[1][4]).toEqual value: 'ng-src', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']
      expect(lines[1][12]).toEqual value: 'ng-click', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']

    it 'tokenizes ng-view attribute without value inside HTML', ->
      lines = grammar.tokenizeLines '''
        <div ng-view class="view-frame"></div>
      '''

      expect(lines[0][3]).toEqual value: 'ng-view', scopes: ['text.html.angular', 'meta.tag.block.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']

    it 'tokenizes capitalized ng-repeat attribute inside HTML', ->
      lines = grammar.tokenizeLines '''
        <dd NG-REPEAT="availability in phone.availability">{{availability}}</dd>
      '''

      expect(lines[0][3]).toEqual value: 'NG-REPEAT', scopes: ['text.html.angular', 'meta.tag.block.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']

    it 'tokenizes ng-controller attribute in body tag', ->
      lines = grammar.tokenizeLines '''
        <body ng-controller="TestCtrl">
      '''

      expect(lines[0][3]).toEqual value: 'ng-controller', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']

    it 'tokenizes ng-s attribute', ->
      lines = grammar.tokenizeLines '''
        <select ng-options="color.name group by color.shade for color in colors">
      '''

      expect(lines[0][3]).toEqual value: 'ng-options', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']

  describe 'directive element', ->
    it 'tokenizes ng-include element inside HTML', ->
      lines = grammar.tokenizeLines '''
        <ng-include src=""></ng-include>
      '''

      expect(lines[0][1]).toEqual value: 'ng-include', scopes: ['text.html.angular', 'meta.tag.block.any.html', 'entity.name.tag.block.any.html.angular']
      expect(lines[0][5]).toEqual value: 'ng-include', scopes: ['text.html.angular', 'meta.tag.block.any.html', 'entity.name.tag.block.any.html.angular']

    it 'tokenizes capitalized ng-include element inside HTML', ->
      lines = grammar.tokenizeLines '''
        <NG-INCLUDE src=""></NG-INCLUDE>
      '''

      expect(lines[0][1]).toEqual value: 'NG-INCLUDE', scopes: ['text.html.angular', 'meta.tag.block.any.html', 'entity.name.tag.block.any.html.angular']
      expect(lines[0][5]).toEqual value: 'NG-INCLUDE', scopes: ['text.html.angular', 'meta.tag.block.any.html', 'entity.name.tag.block.any.html.angular']

  describe 'angular expression', ->
    it 'tokenizes angular expressions in HTML tags', ->
      lines = grammar.tokenizeLines '''
        <dd>{{phone.camera.primary}}</dd>
      '''

      expect(lines[0][3]).toEqual value: '{{', scopes: ['text.html.angular', 'meta.tag.template.angular', 'punctuation.definition.block.begin.angular']
      expect(lines[0][4]).toEqual value: 'phone.camera.primary', scopes: ['text.html.angular', 'meta.tag.template.angular']
      expect(lines[0][5]).toEqual value: '}}', scopes: ['text.html.angular', 'meta.tag.template.angular', 'punctuation.definition.block.end.angular']

    it 'tokenizes angular expressions in value of attributes with double quoted', ->
      lines = grammar.tokenizeLines '''
        <li ng-repeat="phone in phones | filter:query | orderBy:orderProp"></li>
      '''

      expect(lines[0][5]).toEqual value: '"', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'punctuation.definition.string.begin.html.angular']
      expect(lines[0][6]).toEqual value: 'phone in phones | filter:query | orderBy:orderProp', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'meta.tag.template.angular']
      expect(lines[0][7]).toEqual value: '"', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'punctuation.definition.string.end.html.angular']

    it 'tokenizes angular expressions in value of attributes with single quoted', ->
      lines = grammar.tokenizeLines '''
        <li ng-repeat='img in phone.images'>
      '''

      expect(lines[0][5]).toEqual value: '\'', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.single.html.angular', 'punctuation.definition.string.begin.html.angular']
      expect(lines[0][6]).toEqual value: 'img in phone.images', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.single.html.angular', 'meta.tag.template.angular']
      expect(lines[0][7]).toEqual value: '\'', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.single.html.angular', 'punctuation.definition.string.end.html.angular']

    it 'tokenizes angular expressions in value of attributes with {{}}', ->
      lines = grammar.tokenizeLines '''
        <img ng-src="{{img}}" ng-click="{{setImage(img)}}">
      '''

      expect(lines[0][5]).toEqual value: '"', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'punctuation.definition.string.begin.html.angular']
      expect(lines[0][6]).toEqual value: '{{', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'meta.tag.template.angular', 'meta.tag.template.angular', 'punctuation.definition.block.begin.angular']
      expect(lines[0][7]).toEqual value: 'img', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'meta.tag.template.angular', 'meta.tag.template.angular']
      expect(lines[0][8]).toEqual value: '}}', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'meta.tag.template.angular', 'meta.tag.template.angular', 'punctuation.definition.block.end.angular']
      expect(lines[0][9]).toEqual value: '"', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'punctuation.definition.string.end.html.angular']
      expect(lines[0][13]).toEqual value: '"', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'punctuation.definition.string.begin.html.angular']
      expect(lines[0][14]).toEqual value: '{{', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'meta.tag.template.angular', 'meta.tag.template.angular', 'punctuation.definition.block.begin.angular']
      expect(lines[0][15]).toEqual value: 'setImage(img)', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'meta.tag.template.angular', 'meta.tag.template.angular']
      expect(lines[0][16]).toEqual value: '}}', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'meta.tag.template.angular', 'meta.tag.template.angular', 'punctuation.definition.block.end.angular']
      expect(lines[0][17]).toEqual value: '"', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'string.quoted.double.html.angular', 'punctuation.definition.string.end.html.angular']
