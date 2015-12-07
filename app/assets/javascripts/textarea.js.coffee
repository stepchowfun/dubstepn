# called when the DOM is ready
$(document).ready () ->
  # make a textarea automatically adjust its height based on its content
  fit_textarea = (selector) ->
    # loop through each textarea
    $(selector).each (index, element) ->
      # get the textarea
      textarea = $(element)

      # generate a unique id for the doppelganger div
      doppelganger_id = "textarea-doppelganger"

      # create the doppelganger
      $(element).after("<div id='" + doppelganger_id + "' class='doppelganger' />")
      doppelganger = $("#" + doppelganger_id)

      # clone the styles from the textarea
      for prop in [
        "font-family",
        "font-size",
        "font-style",
        "font-variant",
        "font-weight",
        "font-size-adjust",
        "font-stretch",
        "overflow-x",
        "overflow-y",
        "display",
        "padding-top",
        "padding-right",
        "padding-bottom",
        "padding-left",
        "border-top-width",
        "border-right-width",
        "border-bottom-width",
        "border-left-width",
        "border-top-style",
        "border-right-style",
        "border-bottom-style",
        "border-left-style",
        "box-sizing",
        "line-height",
        "text-align",
        "text-indent",
        "vertical-align",
        "white-space",
        "word-spacing",
        "word-wrap",
        "width",
      ]
        doppelganger.css(prop, textarea.css(prop))

      # hack for firefox
      if doppelganger.css("white-space") == "normal"
        doppelganger.css("white-space", "pre-wrap")

      # fill the doppelganger with the content of the textarea
      doppelganger.text(textarea.val() + "\n ")

      # resize the textarea based on the height of the doppelganger
      # first we hide the overflow to make the scrollbar disappear
      overflow_x = textarea.css("overflow-x")
      overflow_y = textarea.css("overflow-y")
      textarea.css("overflow-x", "hidden")
      textarea.css("overflow-y", "hidden")
      textarea.height(Math.max(doppelganger.height(), 64) + "px")
      textarea.css("overflow-x", overflow_x)
      textarea.css("overflow-y", overflow_y)

      # destroy the doppelganger
      doppelganger.remove()

  # make all textareas auto-resize
  $("textarea").each (index, element) ->
    if !$(element).hasClass("auto-resize")
      $(element).addClass("auto-resize")
      debounced_fit_textarea = debounce(() -> fit_textarea(element))
      $(element).change debounced_fit_textarea
      $(element).bind "input keyup propertychange", debounced_fit_textarea
      fit_textarea(element)
