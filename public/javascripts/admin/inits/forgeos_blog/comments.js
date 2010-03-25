jQuery(document).ready(function(){
  $('.comment .gray-destroy').live('click',function(e){
    e.preventDefault();
    $(this).prev('input').val(1);
    $(this).parents('.block-container').hide();
    return false;
  });
  //Edition mode in widget carousel item edit
  $('.block-container.widget-modify.comment .edit-link, .block-container.widget-modify.comment .back-link').live('click',function(e){
    var blockContainer = $(this).parents('.block-container.widget-modify').find('.inner_block-container');
    var blockNameBlocks = blockContainer.children('.block-name');
    var blockType = blockContainer.children('.block-type');

    blockType.toggle();
    blockNameBlocks.toggle();
    blockContainer.toggleClass('open');

    // on closing edition block
    if (!$(blockContainer).hasClass('open')){
      var display_block = blockNameBlocks[0];
      var edition_block = blockNameBlocks[1];

      // update attributes
      if ($(this).hasClass('edit-link')) {
        // title, url and description
        $(edition_block).find('input, textarea, select').each(function(){
            switch(get_rails_element_id($(this)))
              {
              case 'author':
                $(blockType[0]).find('span').text($(this).val());
                break;
              case 'comment':
                $(display_block).find('p').text($(this).val());
                break;
              }
          });
      }
      // reset attributes
      else {
        // title, url and description
        $(edition_block).find('input, textarea, select').each(function(){
            switch(get_rails_element_id($(this)))
              {
              case 'author':
                $(this).val($(blockType[0]).find('span').text().trim());
                break;
              case 'comment':
                $(this).val($(display_block).find('p').text().trim());
                break;
              }
          });
      }
    }
    e.preventDefault();
    return false;
  });  
});
