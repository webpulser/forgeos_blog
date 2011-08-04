jQuery(document).ready(function(){
  jQuery('.comment .gray-destroy').live('click',function(e){
    e.preventDefault();
    jQuery(this).prev('input').val(1);
    jQuery(this).parents('.block-container').hide();
    return false;
  });
  //Edition mode in widget carousel item edit
  jQuery('.block-container.widget-modify.comment .edit-link, .block-container.widget-modify.comment .back-link').live('click',function(e){
    e.preventDefault();
    var blockContainer = jQuery(this).parents('.block-container.widget-modify').find('.inner_block-container');
    var blockNameBlocks = blockContainer.children('.block-name');
    var blockType = blockContainer.children('.block-type');

    blockType.toggle();
    blockNameBlocks.toggle();
    blockContainer.toggleClass('open');

    // on closing edition block
    if (!jQuery(blockContainer).hasClass('open')){
      var display_block = blockNameBlocks[0];
      var edition_block = blockNameBlocks[1];

      // update attributes
      if (jQuery(this).hasClass('edit-link')) {
        // title, url and description
        jQuery(edition_block).find('input, textarea, select').each(function(){
          switch(get_rails_element_id(jQuery(this)))
            {
            case 'name':
              jQuery(blockType[0]).find('span').text(jQuery(this).val());
              break;
            case 'comment':
              jQuery(display_block).find('p').text(jQuery(this).val());
              break;
            }
        });
      }
      // reset attributes
      else {
        // title, url and description
        jQuery(edition_block).find('input, textarea, select').each(function(){
          switch(get_rails_element_id(jQuery(this)))
            {
            case 'name':
              jQuery(this).val(jQuery(blockType[0]).find('span').text().trim());
              break;
            case 'comment':
              jQuery(this).val(jQuery(display_block).find('p').text().trim());
              break;
            }
        });
      }
    }
    return false;
  });
});
