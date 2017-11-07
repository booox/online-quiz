// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require bootstrap/collapse
//= require nested_form_fields
//= require select2



function enable_submit_on_complain_input_validation() {
    var t = 0 !== $("#complain_content").val().length;
    t ? $("#complain-submit-btn").prop("disabled", !1) : $("#complain-submit-btn").prop("disabled", !0)
}


// flash_message
(function($) {
    $.fn.flash_message = function(options) {

      options = $.extend({
        text: 'Done',
        time: 1500,
        how: 'before',
        class_name: ''
      }, options);

      return $(this).each(function() {
        if( $(this).parent().find('.flash_message').get(0) )
          return;

        var message = $('<span />', {
          'class': 'flash_message ' + options.class_name,
          text: options.text
        }).hide().fadeIn('fast');

        $(this)[options.how](message);

        message.delay(options.time).fadeOut('normal', function() {
          $(this).remove();
        });

      });
    };
})(jQuery);


// $(document).ready(function() {
//     $("#complain_content").on("input propertychange", enable_submit_on_complain_input_validation);
// })


$(document).ready(function() {
    // $("#complainModal").find(".modal-dialog").draggable({
    //     handle: ".modal-header";
    // });
    // $("#complainModal").find(".modal-content").on("mouseleave", function() {
    //     $(".posts.posts-show").css("overflow", "auto");
    // });
    // $("#complainModal").find(".modal-content").on("mouseenter", function() {
    //     $(".modal-open").css("overflow", "hidden");
    // });
    // $("#complainModal").on("hidden.bs.modal", function() {
    //     $(".modal-dialog").removeAttr("style");
    //     $(".posts.posts-show").css("overflow", "auto");
    // });
    // $("#want-to-complain-btn").on("click", function() {
    //     $("#complainModal").find("#complainModalLabel").html("\u60a8\u5bf9\u672c\u7bc7\u6559\u7a0b\u6709\u4ec0\u4e48\u60f3\u8bf4\u7684\uff1f");
    //     $(".posts.posts-show").css("overflow-x", "hidden");
    // });
    $("#complain-submit-btn").on("click", function(t) {
        t.preventDefault();
        $(this).prop("disabled", !0);
        $("#new_complain").submit();
        $(this).val("\u63d0\u4ea4\u4e2d...");
    });
    $("#complain_content").on("input propertychange", enable_submit_on_complain_input_validation);
    // $("#complain_image").on("change", enable_submit_on_complain_input_validation);
})
