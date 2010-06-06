jQuery(document).ready(function(){
  // init the category tress
  init_category_tree("#paper-tree",'PaperCategory','/admin/paper_categories.json');

  // init the tress for category associations
  init_association_category_tree('#association-paper-tree', 'paper');
});
