/**

## 🌳 Challenge: **Lowest Common Ancestor in a BST**

### 📝 Problem Statement

Given a binary search tree (BST) and two node values, find the **lowest common ancestor 
(LCA)** of the two nodes. The LCA of two nodes `p` and `q` is defined as the **lowest 
node in the tree that has both `p` and `q` as descendants** (a node can be a descendant of itself).

### ✒️ Function Signature

```swift
func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode, _ q: TreeNode) -> TreeNode?
```

### ✅ Input

- `root`: The root node of a binary search tree.
- `p` and `q`: Two nodes present in the tree (you may assume both nodes exist).
- All node values are **unique integers**.

### 🎯 Output

- Return the node representing the **lowest common ancestor** of `p` and `q`.

---

### 📌 Constraints

- Time Complexity: Ideally **O(log n)** if the tree is balanced.
- You **must** leverage the BST property (left < root < right).
- The tree will have at least 2 nodes.
- You can assume both `p` and `q` exist in the tree and are different.

---

### 📘 Example

#### Input Tree:
```
        6
       / \
      2   8
     / \ / \
    0  4 7  9
      / \
     3   5
```

#### Case 1
```swift
p = 2, q = 8
```
- Expected Output: `6`  
- Explanation: 6 is the common ancestor of both 2 and 8.

#### Case 2
```swift
p = 2, q = 4
```
- Expected Output: `2`  
- Explanation: 2 is an ancestor of itself and 4.

---

### 🧪 Test Cases

| `p` | `q` | Expected Output |
|-----|-----|-----------------|
| 2   | 8   | 6               |
| 2   | 4   | 2               |
| 3   | 5   | 4               |
| 0   | 5   | 2               |
| 7   | 9   | 8               |

---

### 💡 Bonus Challenge

- Implement this for a **general binary tree** (not just BST), where you **cannot** use the BST property.

*/
import Foundation

class lowestCommonAncestor: Problem {
    
    class TreeNode<T: Comparable>: NSObject {
        var val: T 
        var left: TreeNode<T>?
        var right: TreeNode<T>?
        
        init(val: T, leftLeaf: TreeNode? = nil, rightLeaf: TreeNode? = nil) {
            self.val    = val
            self.left   = leftLeaf
            self.right  = rightLeaf
        }
        func printTree() {
            printFrom(head: self)
        }
        
        private func printFrom(head: TreeNode?) {
            print("Head: \(String(describing: head?.val))")
            print("Left: \(String(describing: head?.left?.val))")
            print("Right: \(String(describing: head?.right?.val))\n")
            
            if head?.left != nil { 
                printFrom(head: head?.left)
            }
            if head?.right != nil {
                printFrom(head: head?.right)
            }
        }
        
        func printArrayValue() {
            print(self.convertToArray(from: self).description)
        }
        
        func convertToArray(from head: TreeNode? = nil) -> [T] {
            //  Start all the way left
            //  Add first one
            //  Go up one, check leaves on right
            //  If left child, keep going left until bottom
            //  Add next one
            //  Go up one, do the same. 
            //  If no more on left, 
            var result: [T] = []
            
            func inOrder(_ node: TreeNode<T>?) {
                //  Add left (traversed), head, then right(traversed)
                guard let val = node?.val else { return }
                inOrder(node?.left)
                result.append(val)
                inOrder(node?.right)
            }
            
            inOrder(head)
            return result
        }
    }
    
    override func performTests() {
        let inputTree: TreeNode = TreeNode(
            val: 6, 
            leftLeaf: TreeNode(
                val: 2, 
                leftLeaf: TreeNode(
                    val: 0, 
                    leftLeaf: nil, 
                    rightLeaf: nil
                ), 
                rightLeaf: TreeNode(
                    val: 4, 
                    leftLeaf: TreeNode(
                        val: 3, 
                        leftLeaf: nil, 
                        rightLeaf: nil
                    ), 
                    rightLeaf: TreeNode(
                        val: 5, 
                        leftLeaf: nil, 
                        rightLeaf: nil
                    )
                )
            ), 
            rightLeaf: TreeNode(
                val: 8, 
                leftLeaf: TreeNode(
                    val: 7, 
                    leftLeaf: nil, 
                    rightLeaf: nil
                ), 
                rightLeaf: TreeNode(
                    val: 9, 
                    leftLeaf: nil, 
                    rightLeaf: nil
                )
            )
        )
        typealias TestCase = (p: Int, q: Int, expected: Int) 
        let tests: [TestCase] = [
            (2, 8, 6),
            (2, 4, 2),
            (3, 5, 4), 
            (0, 5, 2), 
            (7, 9, 8)
        ]
        
        
        for (iter, test) in tests.enumerated() {
            let result = lowestCommonAncestor(inputTree, TreeNode(val: test.p), TreeNode(val: test.q))
            let isPassed = result?.val == test.expected
            let height: Int = heightOf(tree: inputTree)
            print("Test \(iter + 1): \t \(isPassed ? "✅" : "❌"): \t\(test) \(height)")
        }
    }
    
    func lowestCommonAncestor<T: Comparable>(
        _ root: TreeNode<T>?, 
        _ p: TreeNode<T>, 
        _ q: TreeNode<T>
    ) -> TreeNode<T>? {
        
        //  Root is required
        guard let root 
            else { return nil }
        
        if p.val < root.val && q.val < root.val {
            //  We know they are on the left
            return lowestCommonAncestor(root.left, p, q)
        } else if p.val > root.val && q.val > root.val {
            //  We know they are on the right
            return lowestCommonAncestor(root.right, p, q)
        }
        
        //  Else, they are on different sides, and the current root is the 
        //  LCA
        return root
    }
    
/**

## 🌲 Challenge: **Find the Height of a Binary Tree**

### 📝 Problem Statement

Given the root of a binary tree, write a function to calculate its **height**. 
The height is defined as the **number of edges** on the longest downward path from the 
root to a leaf node.

---

### ✒️ Function Signature

```swift
func treeHeight<T>(_ root: TreeNode<T>?) -> Int
```

---

### 📘 Example Tree

Same tree as earlier, built from:

```swift
let sorted = [1, 2, 3, 4, 5, 6, 7]
let root = TreeNode(sortedValues: sorted)
```

This gives us a **balanced** BST like:

```
        4
      /   \
     2     6
    / \   / \
   1   3 5   7
```

---

### ✅ Expected Output

```swift
treeHeight(root) // Output: 2
```

Explanation:
- Longest path: 4 → 2 → 1 (or 4 → 6 → 5, etc.)
- That’s 2 **edges**, so the height is `2`.

---

### 📦 Test Cases

| Tree Structure Description                 | Height |
|--------------------------------------------|--------|
| Single node: `4`                            | `0`    |
| Left-skewed: `4 → 3 → 2 → 1`                | `3`    |
| Balanced: as shown above                    | `2`    |
| Right-skewed: `1 → 2 → 3 → 4 → 5`           | `4`    |

---

### 🛠 Constraints

- Use a **recursive approach**.
- Bonus points for implementing **iterative (BFS)** version.
- Must handle empty tree input (`nil`) gracefully.
*/
    func heightOf<T: Comparable>(tree: TreeNode<T>?) -> Int {
        guard let tree 
            else { return -1 }
        
        return 1 + max(
            heightOf(tree: tree.left), 
            heightOf(tree: tree.right)
        )
    }
}