// clone content from div to form and then submit the form
function update_comment(display_div, edition_div){
  $(display_div).find('.edit-link').trigger('click');
}

// hide carousel item container and set item delete value to 1
function remove_comment(destroy_link){
  var block = $(destroy_link).parents('.block-container');
  $(block).hide();
  $(block).find('.delete').val(1);
}
