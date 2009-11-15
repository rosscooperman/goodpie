// when the document is ready
$(function() {
  // handler for click events on submit buttons
  $("input[type=submit]").bind("click", function(e) {
    var target = $(e.target);
    target.next("a:contains('Cancel')").hide();
    target.disabled = true;
    target.addClass("disabled");
    target.val(target.val().replace(/Create/, 'Creating'));
    target.val(target.val().replace(/Update/, 'Updating'));
    target.val(target.val() + '...');
  });
});