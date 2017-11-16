// ==================================================== //
// O TRECHO ABAIXO NAO ESTA FUNCIONANDO -- tipagem NO
// EXCLUSAO ... NAO IMPLEMENTADA 
/* Given a non-empty binary search tree, return the node with minimum
   key value found in that tree. Note that the entire tree does not
   need to be searched. 
   VEIO de http://www.geeksforgeeks.org/binary-search-tree-set-2-delete/
   * */
BinTreeNode * minValueNode(BinTreeNode * node)
{
    struct node* current = node;
 
    /* loop down to find the leftmost leaf */
    while (current->left != NULL)
        current = current->left;
 
    return current;
}
// versao recursiva
// VEIO DE https://helloacm.com/how-to-delete-a-node-from-a-binary-search-tree/ 
BinTreeNode * Delete_NODE(BinTreeNode *root, int data) {
  if (root == NULL) {
     return NULL;
  }
  if (data < root->data) {  // data is in the left sub tree.
      root->left = Delete_NODE(root->left, data);
  } else if (data > root->data) { // data is in the right sub tree.
      root->right = Delete_NODE(root->right, data);
  } else {
     // case 1: no children
     if (root->left == NULL && root->right == NULL) {
        free(root); // wipe out the memory, in C, use free function
        root = NULL;
     }
     // case 2: one child (right)
     else if (root->left == NULL) {
        struct Node *temp = root; // save current node as a backup
        root = root->right;
        free(temp);
     }
     // case 3: one child (left)
     else if (root->right == NULL) {
        struct Node *temp = root; // save current node as a backup
        root = root->left;
        free(temp);
     }
     // case 4: two children
     else {
		//O MENOR VALOR da sub-ARVORE A DIREITA ... o qual
		// vai estar a esquerda .... 
        struct Node *temp = minValueNode(root->right); // find minimal value of right sub tree
        root->data = temp->data; // duplicate the node
        root->right = Delete(root->right, temp->data); // delete the duplicate node
     }
  }
  return root; // parent node can update reference
}
 
