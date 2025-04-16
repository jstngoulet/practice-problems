/**
### Problem Prompt: Finding the Intersection of Two Linked Lists

Given two singly linked lists that intersect at some point, write a function to find the intersecting node. The lists are **non-cyclical**, meaning they do not loop back on themselves.

### Input:
- Two singly linked lists, **A** and **B**, where each list is represented by the head node of the list.
- The lists are guaranteed to intersect at exactly one node. 
- The node where the two lists intersect is the same object in memory, meaning they share the same reference, not just the same value.
  
### Output:
- Return the **intersecting node** where the two linked lists meet, or `null` if no intersection exists. In this case, it's guaranteed that there is an intersection.

### Example:

**Example 1:**

```plaintext
A = 3 -> 7 -> 8 -> 10
B = 99 -> 1 -> 8 -> 10
```

Output:
```plaintext
Node with value 8
```

**Example 2:**

```plaintext
A = 1 -> 2 -> 3
B = 4 -> 5
```

Output:
```plaintext
null
```

### Constraints:
- The time complexity must be **O(M + N)**, where M and N are the lengths of the two linked lists.
- The space complexity must be **O(1)**, meaning you cannot use extra space proportional to the size of the lists (e.g., no use of hash maps or lists).
  
### Approach:
- The key idea is to align the lists and walk them simultaneously, comparing nodes at each step.
- After aligning the lists (by accounting for their differences in lengths), the goal is to traverse them at the same pace until the intersecting node is found or it is determined there is no intersection.

### Function Signature:
```swift
func getIntersectionNode(headA: ListNode?, headB: ListNode?) -> ListNode?
``` 

Where:
- `headA` and `headB` are the head nodes of the two singly linked lists.

---

### Notes:
- A list can have any number of nodes (including zero nodes).
- The intersecting node is guaranteed to exist, or it is known that the lists will never intersect.
- Do not assume that the lists are sorted or have any other specific structure beyond the intersection.
*/
import Foundation

class IntersetingLinkedLists: Problem {
    
    
    class Node<T>: NSObject {
        var val: T
        var next: Node<T>?
        
        init(value: T, nextNode: Node<T>? = nil) {
            self.val = value
            self.next = nextNode
        }
        
        func insert(val: T) {
            var head: Node = self
            
            while let next = head.next {
                head = next
            }
            head.next = Node(value: val)
        }
        
        convenience init?(with ar: [T]) {
            if ar.isEmpty { return nil }
            self.init(value: ar[0])
            var head: Node = self
            
            for iter in 1..<ar.count {
                let tmp = Node(value: ar[iter])
                head.next = tmp
                head = tmp
            }
        }
        
        func printList() {
            var current: Node? = self
            var output = ""
            
            while let node = current {
                output += "\(node.val) -> "
                current = node.next
            }
            
            output += "nil"
            print(output)
        }
        
    }
    
    override func performTests() {
        typealias TestCase = (ar1: [Int], ar2: [Int], expected: Int?)
        let tests: [TestCase] = [
            // Test case 1: Common element in both arrays
            ([1, 2, 3, 4], [4, 5, 6], 4),

            // Test case 2: No common element between the arrays
            ([1, 2, 3], [4, 5, 6], nil),

            // Test case 3: One array is empty
            ([], [1, 2, 3], nil),

            // Test case 4: Single common element
            ([10], [10], 10),

            // Test case 5: Arrays with multiple common elements
            ([1, 2, 3, 4], [3, 4, 5, 6], 3),

            // Test case 6: Arrays are identical
            ([1, 2, 3], [1, 2, 3], 1),

            // Test case 7: Arrays with no intersection but overlapping elements
            ([1, 2, 3], [3, 4, 5], 3),

            // Test case 8: Common element at the start of the arrays
            ([7, 8, 9], [7, 10, 11], 7),

            // Test case 9: Common element at the end of the arrays
            ([1, 2, 3], [3, 4, 5], 3),

            // Test case 10: Arrays with negative and positive numbers
            ([-1, 2, 3], [0, -1, 4], -1)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result: Int? = findIntersection(of: Node(with: test.ar1.sorted()), and: Node(with: test.ar2.sorted()))
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")\tE: \(test.expected ?? -99)\tR: \(result ?? -99)")
        }
    }
    
    func findIntersection<T: Comparable>(of listA: Node<T>?, and listB: Node<T>?) -> T? {
        
        var leftHead: Node<T>? = listA
        var rightHead: Node<T>? = listB
        
        if listA == nil || listB == nil { return nil }
        
        while let leftItem = leftHead, 
            let rightItem = rightHead  {
            
            if leftItem.val == rightItem.val 
            { return leftItem.val }
            
            if leftItem.val < rightItem.val {
                leftHead = leftItem.next
            } else if leftItem.val > rightItem.val {
                rightHead = rightItem.next
            }
            
            //  1, 2, 3, 4
            //  -, -, -, 4, 5, 6
        }
        
        //  No intersection found
        return nil
    }
}