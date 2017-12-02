# ref https://github.com/atom/autocomplete-html/blob/master/lib/provider.coffee

COMPLETIONS = require '../completions.json'

attributePattern = /\s+([a-zA-Z][-a-zA-Z]*)\s*=\s*$/

module.exports =
  selector: '.source.js, .text.html'
  disableForSelector: '.source.js .comment, .text.html .comment'
  filterSuggestions: true
  completions: COMPLETIONS

  getSuggestions: (request) ->
    if @isJavaScript(request)
      console.log('is js');
      []
    else if @isHtml(request)
      if @isAttributeStart(request)
        @getAttributeNameCompletions(request)
      else if @isTagStart(request)
        @getTagNameCompletions(request)
    else
      []

  isJavaScript: ({ scopeDescriptor }) ->
    for scope in scopeDescriptor.getScopesArray()
      return true if scope.startsWith('source') and scope.endsWith('.js')
    return false

  isHtml: ({ scopeDescriptor }) ->
    for scope in scopeDescriptor.getScopesArray()
      return true if scope.endsWith('.html')
    return false

  isAttributeStart: ({prefix, scopeDescriptor, bufferPosition, editor}) ->
    scopes = scopeDescriptor.getScopesArray()
    return @hasTagScope(scopes) if not @getPreviousAttribute(editor, bufferPosition) and prefix and not prefix.trim()

    previousBufferPosition = [bufferPosition.row, Math.max(0, bufferPosition.column - 1)]
    previousScopes = editor.scopeDescriptorForBufferPosition(previousBufferPosition)
    previousScopesArray = previousScopes.getScopesArray()

    return true if previousScopesArray.indexOf('entity.other.attribute-name.html') isnt -1
    return false unless @hasTagScope(scopes)

    # autocomplete here: <tag |>
    # not here: <tag >|
    scopes.indexOf('punctuation.definition.tag.end.html') isnt -1 and
      previousScopesArray.indexOf('punctuation.definition.tag.end.html') is -1

  isTagStart: ({ prefix, scopeDescriptor, bufferPosition, editor }) ->
    return @hasTagScope(scopeDescriptor.getScopesArray()) if prefix.trim() and prefix.indexOf('<') is -1

    # autocomplete-plus's default prefix setting does not capture <. Manually check for it.
    prefix = editor.getTextInRange([[bufferPosition.row, bufferPosition.column - 1], bufferPosition])

    scopes = scopeDescriptor.getScopesArray()

    # Don't autocomplete in embedded languages
    prefix is '<' and scopes[0] is 'text.html.basic' and scopes.length is 1

  hasTagScope: (scopes) ->
    for scope in scopes
      return true if scope.startsWith('meta.tag.') and scope.endsWith('.html')
    return false

  hasStringScope: (scopes) ->
    scopes.indexOf('string.quoted.double.html') isnt -1 or
      scopes.indexOf('string.quoted.single.html') isnt -1

  getAttributeNameCompletions: ({prefix, editor, bufferPosition}) ->
    completions = []
    cantidates = @completions.directives.concat @completions.attributes
    for idx, attribute of cantidates when not prefix.trim() or firstCharsEqual(attribute, prefix)
      completions.push({ text: attribute, type: 'attribute' })
    completions

  getTagNameCompletions: ({ prefix, editor, bufferPosition }) ->
    # autocomplete-plus's default prefix setting does not capture <. Manually check for it.
    ignorePrefix = editor.getTextInRange([[bufferPosition.row, bufferPosition.column - 1], bufferPosition]) is '<'

    completions = []
    for idx, tag of @completions.directives when ignorePrefix or firstCharsEqual(tag, prefix)
      completions.push({ text: tag, type: 'tag' })
    completions

  getPreviousAttribute: (editor, bufferPosition) ->
    # Remove everything until the opening quote (if we're in a string)
    quoteIndex = bufferPosition.column - 1 # Don't start at the end of the line
    while quoteIndex
      scopes = editor.scopeDescriptorForBufferPosition([bufferPosition.row, quoteIndex])
      scopesArray = scopes.getScopesArray()
      break if not @hasStringScope(scopesArray) or scopesArray.indexOf('punctuation.definition.string.begin.html') isnt -1
      quoteIndex--

    attributePattern.exec(editor.getTextInRange([[bufferPosition.row, 0], [bufferPosition.row, quoteIndex]]))?[1]

firstCharsEqual = (str1, str2) ->
  str1[0].toLowerCase() is str2[0].toLowerCase()
