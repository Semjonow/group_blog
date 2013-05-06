class GroupBlog.Views.Common.ModalForm extends Middleware.Component.JsonForm
  constructor: (@container) ->
    super(@container)
    @container.foundation("reveal", "open")
    @closeButton = @container.find("*[data-action='close']")
    @closeButton.on "click", @close

    @container.bind "closed", =>
      $(".reveal-modal-bg").remove()
      $("*[data-block='modal_form']").remove()

  completeForm: (event, json) =>
    window.location.replace(json["url"])

  updateForm: (event, json) =>
    @container.html(json["template"])
    @reBind()

  close: =>
    @container.foundation("reveal", "close")
