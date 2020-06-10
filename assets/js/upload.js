
// Copied from https://www.poeticoding.com/add-a-progress-bar-in-the-phoenix-file-upload-app/

import jQuery from "jquery"

jQuery(document).ready(function ($) {
  let $form = $("#upload_form");

  $form.submit(function (event) {
    let formData = new FormData(this);
    startUpload(formData, $form);

    event.preventDefault();
  })
})


function startUpload(formData, $form) {
  let $progress = $form.find("progress");
  $progress.show()

  jQuery.ajax({
    type: 'POST',
    url: '/uploads',
    data: formData,
    processData: false, //IMPORTANT!
    cache: false,
    contentType: false,

    xhr: function () {
      let xhr = jQuery.ajaxSettings.xhr();
      if (xhr.upload) {

        xhr.upload.addEventListener(
          'progress',
          createProgressHandler($form),
          false
        );

      }
      return xhr;
    },

    success: function (data) {
      window.location = "/uploads"
    },

    error: function (data) {
      console.error(data);
    }
  })
}

// function handleProgressEvent(progressEvent) {
//   console.log(progressEvent);
// }

function createProgressHandler($form) {
  let $progress = $form.find("progress"),
    $label = $form.find("label.progress-percentage");

  return function handleProgressEvent(progressEvent) {
    let progress = progressEvent.loaded / progressEvent.total,
      percentage = progress * 100,
      percentageStr = `${percentage.toFixed(2)}%`; //xx.xx%

    $label.text(percentageStr)

    //PROGRESS BAR
    $progress
      .attr("max", progressEvent.total)
      .attr("value", progressEvent.loaded);
  }
}
