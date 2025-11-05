$(document).on('focusout', 'input[type=text]', function(e) {
  ga('send', 'event', 'widget', 'Name', $(e.currentTarget).val());
});
/*
$(document).on('change', 'select', function(e) {
  ga('send', 'event', 'widget', 'Gender', $(e.currentTarget).val());
});*/

$(document).on('click', 'button', function() {
  ga('send', 'event', 'button', 'Apply');
});