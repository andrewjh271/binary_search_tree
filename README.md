# Binary Search Tree

Created as part of The Odin Project Curriculum.

### Functionality

- On instantiation of Tree class, `build_tree` creates a balanced binary search tree from an ordered array
- Duplicate values are not allowed — they will be removed during instantiation and `insert` will not accept them
- `display` can display a tree of up to 5 levels
- Basic operations: `insert`, `delete`, `find`
- Traversals: `level_order`, `preorder`, `inorder`, `postorder`
- `depth` returns the number of levels below a given node, or below root if no argument is given
- Other methods: `balanced?`, `rebalance`

### Thoughts

After finishing the initial functionality, I made a real effort to refactor my code. Most notably, I was able to make my recursive methods much more succinct, and I felt it was very valuable going through that process. 

I learned a bit about allowing blocks inside my methods. I first used `yield`, but this isn't possible inside `define_method`, so switched to using `block.call`. 

One "secret" I had to uncover for `define_method` was using `self` to recursively call the method being defined.

-Andrew Hayhurst