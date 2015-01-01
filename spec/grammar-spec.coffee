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

      console.log(lines[1][4])

      expect(lines[0][3]).toEqual value: 'ng-repeat', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']
      expect(lines[1][4]).toEqual value: 'ng-src', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']
      expect(lines[1][10]).toEqual value: 'ng-click', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'meta.attribute.html.angular', 'entity.other.attribute-name.html.angular']

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
