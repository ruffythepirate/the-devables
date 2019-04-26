# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

titleText = document.getElementById('title')
textarea = document.getElementById('raw-value')
renderedView = document.getElementById('rendered-value')
saveButton = document.getElementById('save-button')

textarea.onkeypress = ->
  debounce(1000, updateView)

savePost = ->
  title = titleText.value
  content = textarea.value
  callAjaxPost('/api/blog_posts', {title, content}, -> console.log('saved!'))

saveButton.onclick = savePost

callAjaxPost = (url, body, callback) ->
  xhttp = new XMLHttpRequest()
  xhttp.onreadystatechange = ->
    if this.readyState == 4  && this.status == 200
      callback(this.responseText)


  xhttp.open("POST", url, true)
  xhttp.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
  xhttp.send(body)

setRenderedContent = (content) ->
  renderedView.innerHTML = content

updateView = ->
  console.log 'update'
  callAjaxPost('/api/blog-post/md-to-html', textarea.value, setRenderedContent)


pendingQuery = null
lastCall = null

debounceInner = (delay, callFunction) ->
  pendingQuery = setTimeout ->
    currentCall = new Date()
    pendingQuery = null
    if currentCall.getTime() - lastCall.getTime() < delay
      timeSinceLastCall = currentCall.getTime() - lastCall.getTime()
      debounceInner(delay - timeSinceLastCall, callFunction)
    else
      callFunction()
  , delay

debounce = (delay, callFunction) ->
  lastCall = new Date()
  if !pendingQuery
    debounceInner(delay, callFunction)

