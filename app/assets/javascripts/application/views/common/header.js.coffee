class GroupBlog.Views.Common.Header extends Middleware.System.Base
  constructor: (@container) ->
    super(@container)
    @initElements()

  initElements: =>
    @container.sticky()

    @modalButtons = @container.find("a[data-action='modal']")
    @modalButtons.on "ajax:success", @createResponse

  createResponse: (event, json) =>
    $("body").append(json.template)
    GroupBlog.Views.Common.ModalForm.bindOne("*[data-block=modal_form]")

jQuery ->
  GroupBlog.Views.Common.Header.bindOne("*[data-block='header']")