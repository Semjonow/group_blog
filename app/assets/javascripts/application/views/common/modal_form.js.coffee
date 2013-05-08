class GroupBlog.Views.Common.ModalForm extends Middleware.Component.JsonForm
  constructor: (@container) ->
    super(@container)
    @container.foundation("reveal", "open")

    redactors = @container.find("*[data-block='redactor']")
    if redactors.length > 0
      redactors.redactor({"imageUpload":"/redactor_rails/pictures" + "?" + $('meta[name=csrf-param]').attr('content') + "=" + encodeURIComponent($('meta[name=csrf-token]').attr('content')),"imageGetJson":"/redactor_rails/pictures","lang":"en","autoresize":true})

    @closeButton = @container.find("*[data-action='close']")
    @closeButton.on "click", @close

    @container.bind "closed", =>
      $(".reveal-modal-bg").remove()
      $("*[data-block='modal_form']").remove()

  completeForm: (event, json) =>
    window.location.replace(json["url"])

  updateForm: (event, json) =>
    @container.find("form").replaceWith(json["template"])
    @container.find("*[data-action]").unbind()
    @reBind()

  close: =>
    @container.foundation("reveal", "close")
