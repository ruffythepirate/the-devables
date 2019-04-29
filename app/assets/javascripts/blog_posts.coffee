# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

titleText = document.getElementById('title')
textarea = document.getElementById('raw-value')
renderedView = document.getElementById('rendered-value')
saveButton = document.getElementById('save-button')

textarea && textarea.onkeypress = ->
  debounce(800, updateView)


csrf_token = $('meta[name="csrf-token"]').attr('content')
$.ajaxSetup({
  beforeSend: (xhr) ->
    xhr.setRequestHeader('X-CSRF-TOKEN', csrf_token)
})

buildBlogPost = ->
  id = document.getElementById('id').value
  title = titleText.value
  body = textarea.value
  item = {id, title, body}
  item["blog_post"] = {title, body}
  item

savePost = ->
  post = buildBlogPost()
  if post.id
    updatePost post
  else
    createPost post

createPost = (post) ->
  sendSaveRequest('POST', post, (response) ->
    # redirect to edit page.
    id = response.id
    window.location.replace("/blog_posts/#{id}/edit")
    console.log('success'))

updatePost = (post) ->
  sendSaveRequest('PATCH', post, ->
    console.log('success'))

sendSaveRequest = (method, post, successCallback) ->
  $.ajax({
    url: "/api/blog-posts",
    data: JSON.stringify(post),
    type: method,
    contentType: 'application/json; charset=utf-8',
    dataType: 'json',
    async: false,
    success: successCallback
    error: ->
      # show a warning message.
      console.log "fail"
  })



saveButton && saveButton.onclick = savePost

callAjaxPost = (url, body, callback) ->
  xhttp = new XMLHttpRequest()
  xhttp.onreadystatechange = ->
    if this.readyState == 4  && (this.status == 200 || this.status == 204)
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

textarea && updateView()

$('document').ready(->
  publishButtons = [].slice.call(document.getElementsByClassName('action-publish'))

  publishButtons && publishButtons.forEach (button) ->
    button.onclick = togglePublish
)

togglePublish = ->
  toggleState = getAttributeValue(this,'blog-post-published') == 'true'
  id = getAttributeValue(this, 'blog-post-id')
  newState = if toggleState then "false" else "true"
  self = this
  callAjaxPost("/api/blog-posts/#{id}/set-published", newState, ->
    toggleState = !toggleState
    setAttributeValue(self, 'blog-post-published', toggleState)
    self.text = if toggleState then "unpublish" else "publish"
  )

getAttributeValue = (el, attributeName) ->
  attr = getAttribute(el, attributeName)
  attr && attr.value

setAttributeValue = (el, attributeName, value) ->
  attr = getAttribute(el, attributeName)
  attr && attr.value = value

getAttribute = (el, attributeName) ->
  attr = el.attributes.getNamedItem(attributeName) || el.attributes.getNamedItem('data-' + attributeName)



