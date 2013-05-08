class GroupBlog.Views.Posts.List extends Middleware.System.Base
  constructor: (@container) ->
    super(@container)
    @initElements()

  initElements: =>
    @commentsButtons = @container.find("a[data-action='comments']")
    @commentsButtons.on "ajax:success", @commentsResponse

  commentsResponse: (event, json) =>
    $("body").append(json.template)
    GroupBlog.Views.Common.ModalForm.bindOne("*[data-block=modal_form]")

jQuery ->
  GroupBlog.Views.Posts.List.bindMany("*[data-block='posts']")