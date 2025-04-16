/**
### **Problem: Merge Two Sorted Linked Lists**

#### **Problem Statement:**

You are given two sorted singly linked lists. Write a function to merge them into a single sorted linked list. The merged list should be sorted in **non-decreasing order**.

**Function Signature:**
```swift
func mergeTwoSortedLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode?
```

#### **Input:**
- You are given two singly linked lists `l1` and `l2`. Each list has nodes with integer values and is already sorted in **non-decreasing order**.
- Each list is represented as a singly linked list, where each node is an instance of the following class:

```swift
class ListNode {
    var val: Int
    var next: ListNode?
    init(val: Int, next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}
```

#### **Output:**
- The function should return a new **sorted** linked list that contains all the elements from both `l1` and `l2`.

#### **Constraints:**
- Both `l1` and `l2` can be empty. In that case, return the other list.
- The length of the lists is at most 10^4, and the elements of the lists are integers.
- The time complexity of the solution should be **O(n + m)**, where `n` and `m` are the lengths of `l1` and `l2`, respectively.

#### **Example 1:**

**Input:**
```swift
let l1 = ListNode(val: 1, next: ListNode(val: 2, next: ListNode(val: 4)))
let l2 = ListNode(val: 1, next: ListNode(val: 3, next: ListNode(val: 4)))
let mergedList = mergeTwoSortedLists(l1, l2)
```

**Output:**
```swift
1 -> 1 -> 2 -> 3 -> 4 -> 4
```

#### **Example 2:**

**Input:**
```swift
let l1 = ListNode(val: 5)
let l2 = ListNode(val: 1)
let mergedList = mergeTwoSortedLists(l1, l2)
```

**Output:**
```swift
1 -> 5
```

#### **Example 3:**

**Input:**
```swift
let l1: ListNode? = nil
let l2: ListNode? = nil
let mergedList = mergeTwoSortedLists(l1, l2)
```

**Output:**
```swift
nil
```

---

### **Requirements:**

1. **Understanding of Linked Lists**:
   - Understand how singly linked lists work, including how nodes are connected via a `next` pointer.
   - Be able to traverse the list by following the `next` pointers.

2. **Merge Logic**:
   - Since both linked lists are sorted, the goal is to merge them in a sorted fashion.
   - Traverse both lists, comparing the values at the current nodes of both lists.
   - Append the smaller value to the merged list, and move the pointer of the list from which the value was taken.
   - Continue the process until both lists are fully traversed.

3. **Edge Cases**:
   - One of the lists is empty.
   - Both lists are empty.
   - The lists have equal lengths.
   - All elements in one list are smaller than those in the other list.

---

### **Approach (Hint for Solution)**:

1. **Iterative Approach (Two Pointers)**:
   - Start with two pointers, one for each list (`l1` and `l2`).
   - Compare the values at each pointer. Append the smaller value to the result list.
   - Move the pointer of the list from which the smaller value was taken.
   - If one list is exhausted before the other, append the remaining elements of the non-exhausted list.
   - Use a dummy node to simplify the logic of handling the head of the merged list.

2. **Recursive Approach** (Optional):
   - Base case: If one of the lists is empty, return the other list.
   - Recursive case: Compare the values of the heads of the two lists and recursively merge the rest of the lists.

---

### **Solution Outline**:

1. **Create a dummy node** to hold the merged result.
2. **Use two pointers** to iterate through both lists (`l1` and `l2`).
3. At each step, compare the current nodes of both lists:
   - Append the smaller node to the merged list.
   - Move the pointer of the list from which the smaller node was taken.
4. Once one of the lists is fully traversed, append the remaining elements from the other list.
5. Return the merged list starting from the node after the dummy node.

*/

import Foundation
import Swift

class Merge2Lists: Problem {
    
    /**
        Given Class (linked List)
    */    
    class ListNode<T>: NSObject {
        var val: T
        var next: ListNode?
        init(val: T, next: ListNode? = nil) {
            self.val = val
            self.next = next
        }
        
        func printList() {
            var current: ListNode? = self
            var output = ""
            
            while let node = current {
                output += "\(node.val) -> "
                current = node.next
            }
            
            output += "nil"
            print(output)
        }
        
        func insert(item: ListNode) {
           var current: ListNode<T>? = self
            while current?.next != nil {
                current = current?.next
            }
            current?.next = item
        }
    }

    
    override func performTests() {
        typealias TestCase = (arr1: [Int], arr2: [Int], expected: [Int])
        let tests: [TestCase] = [
            ([1, 2, 3], [2, 3, 4], [1, 2, 2, 3, 3, 4]),
            ([], [], []),                               // both empty
            ([1, 3, 5], [], [1, 3, 5]),                 // second empty
            ([], [2, 4, 6], [2, 4, 6]),                 // first empty
            ([1, 3, 5], [2, 4, 6], [1, 2, 3, 4, 5, 6]), // interleaved merge
            ([1, 2, 3], [4, 5, 6], [1, 2, 3, 4, 5, 6]), // all from l1 first
            ([4, 5, 6], [1, 2, 3], [1, 2, 3, 4, 5, 6]), // all from l2 first
            ([1, 1, 2], [1, 3, 4], [1, 1, 1, 2, 3, 4]), // with duplicates
        ]
        
        for (iter, test) in tests.enumerated() {            
            //  Now that we merge the 2 lists, do basic
            let result = mergeSortedLists(arrayToLinkedList(test.arr1), arrayToLinkedList(test.arr2))
            let isPassed = linkedListToArray(result) == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")\tarr1: \(test.arr1)\t\tarr2: \(test.arr2)\t\tResult: \(linkedListToArray(result))")
        }
    }
    
    func mergeSortedLists<T: Comparable>(_ l1: ListNode<T>?, _ l2: ListNode<T>?) -> ListNode<T>? {
        guard let l2 else { return l1 }
        guard let l1 else { return l2 }
        
        //  Dummy val will not be used as we just need a starting point
        let dummy = ListNode<T>(val: l1.val < l2.val ? l1.val : l2.val)
        var tail = dummy
        var a: ListNode<T>? = l1
        var b: ListNode<T>? = l2

        while let nodeA = a, 
            let nodeB = b {
            if nodeA.val < nodeB.val {
                tail.next = nodeA
                tail = nodeA
                a = nodeA.next
            } else {
                tail.next = nodeB
                tail = nodeB
                b = nodeB.next
            }
        }

        tail.next = a ?? b
        return dummy.next
    }

    
    func arrayToLinkedList<T>(_ array: [T]) -> ListNode<T>? {
        guard !array.isEmpty else { return nil }
        
        let dummy = ListNode<T>(val: array[0]) // Dummy to help start the list
        var current = dummy
        
        for value in array.dropFirst() {
            current.next = ListNode<T>(val: value)
            current = current.next!
        }
        
        return dummy
    }
    
   func linkedListToArray<T>(_ head: ListNode<T>?) -> [T] {
        var result: [T] = []
        var current = head
        
        while let node = current {
            result.append(node.val)
            current = node.next
        }
        
        return result
    }
    
    
}