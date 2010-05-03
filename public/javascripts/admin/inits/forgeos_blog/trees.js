jQuery(document).ready(function(){
  // init the category tress
  init_category_tree("#post-tree",'PostCategory','/admin/post_categories.json');

  // init the tress for category associations
  init_association_category_tree('#association-post-tree', 'post');
});
