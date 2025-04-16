
/**
    Problem: Find the middle of a linked list
*/
import Foundation

class MiddleOfLinkedList: Problem {
    
    override func performTests() {
        typealias TestCase<T: Comparable> = (list: [T], expected: T)
        let tests: [TestCase] = [
            ([1, 2, 3], 2),
            (Array(1..<30), 15),
            
            //  Note, for even counts, we are picking lower bounds
            // Test with an odd number of elements (middle item is straightforward)
            ([1, 3, 5], 3),                 // Middle item in [1, 3, 5] is 3
            ([1, 2, 3, 4, 5], 3),           // Middle item in [1, 2, 3, 4, 5] is 3

            // Test with an even number of elements (pick one of the middle items)
            ([1, 2, 3, 4], 2),              // Middle items are 2 and 3, pick 3 (or 2)
            ([7, 8, 9, 10], 8),             // Middle items are 8 and 9, pick 9 (or 8)
            ([10, 20, 30, 40], 20),         // Middle items are 20 and 30, pick 30 (or 20)
            
            // Test with all identical elements
            ([5, 5, 5, 5, 5], 5),           // All elements are the same, so the middle is 5
            
            // Test with negative numbers
            ([-5, -3, -1, 1, 3], -1),       // Odd count, middle item is -1
            ([-2, -1, 0, 1, 2], 0),         // Odd count, middle item is 0
            ([-10, -5, 0, 5, 10], 0),       // Odd count, middle item is 0
            
            // Test with large arrays
            ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5),   // Even count, pick middle item 6
            ([1000, 2000, 3000, 4000, 5000], 3000),  // Odd count, middle item is 3000
            ([100, 200, 300, 400, 500, 600], 300),   // Even count, pick middle item 400
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = getMedianNode(from: arrayToList(ar: test.list))
            let isPassed = result?.val == test.expected
            print("Test \(iter + 1): \(isPassed ? "✅" : "❌")\tResult: \(result?.val ?? -1) Expected: \(test.expected)")
        }
    }
    
    class LinkedList<T: Comparable> {
        var val: T
        var next: LinkedList<T>?
        
        init(withVal val: T, nextNode: LinkedList<T>? = nil) {
            self.val = val
            self.next = nextNode
        }
        
        func insert(item val: T) {
            var head: LinkedList<T> = self
            
            while let next = head.next {
                head = next
            }
            head.next = LinkedList<T>(withVal: val)
        }
    }
    
    func arrayToList<T>(ar: [T]) -> LinkedList<T>? {
        var head: LinkedList<T>?
        
        if ar.isEmpty { return nil }
        head = LinkedList<T>(withVal: ar[0])    //  Dummy value for starting point 
        ar.forEach { head?.insert(item: $0) }
        
        return head?.next
    }
    
    func getMedianNode<T: Comparable>(from list: LinkedList<T>?) -> LinkedList<T>? {
       
       if list == nil { return nil }
        
        var dummyHead = list
        var itemCount: Int = 0
        
        //  First, get the count of items in the current list
        while let next = dummyHead?.next {
            itemCount += 1
            dummyHead = next
        }
        
        //  Now that we have the count, we need to find the midpoint node
        //  Since there can be 2, let's focus on the lower one
        //  First, reset the head
        dummyHead = list
        let midCount: Int = Int(itemCount / 2)
        var midIterator: Int = 0
        
        while let next = dummyHead?.next
            , midIterator < midCount 
        {
            midIterator += 1
            dummyHead = next
        } 
        
        return dummyHead
    }
    
}