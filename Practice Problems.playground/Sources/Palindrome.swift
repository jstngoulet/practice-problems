//
//  Palindrome.swift
//  
//
//  Created by Justin Goulet on 3/24/25.
//

import Foundation

class Palindrome: NSObject {
    
    
    /**
     Problem: Palindrome Checker
     Write a function isPalindrome that takes a string as input and returns true if the string is a palindrome, and false otherwise. A palindrome is a word, phrase, number, or other sequence of characters which reads the same backward as forward (ignoring spaces, punctuation, and capitalization).
     
     Function Signature:
     `func isPalindrome(_ input: String) -> Bool`
     
     Example:
     ```swift
     isPalindrome("racecar")
     // Output: true
     
     isPalindrome("hello")
     // Output: false
     
     isPalindrome("A man a plan a canal Panama")
     // Output: true
     ```
     Constraints:
     The input string will only contain letters, numbers, and spaces.
     The length of the input string is between 1 and 1000.
     
     Hints:
     You can use a two-pointer approach to check if the characters match from both ends of the string.
     You might want to ignore spaces and make everything lowercase to ensure case-insensitivity.
     */
    func isPalindrome(_ input: String) -> Bool {
        
        //  Automatically
        let cleanedInput = clean(input: input)
        return cleanedInput == String(Array(cleanedInput).reversed())
        
        //  Manually
        //        checkManualPalindrome(input)
    }
    
    func checkManualPalindrome(_ input: String) -> Bool {
        let cleanedInput = clean(input: input)
        let asArray = Array(cleanedInput)
        
        //  Now, use the manual 2 pointer approach
        var endPointer = cleanedInput.count - 1
        var startPointer = 0
        
        while startPointer < endPointer {
            
            //  Skip over spaces first
            let startItem = asArray[startPointer]
            let endItem = asArray[endPointer]
            
            if startItem == endItem {
                startPointer += 1
                endPointer -= 1
                continue
            }
            return false
        }
        
        return true
    }
    
    private func clean(input: String) -> String {
        return input.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    override init() {
        super.init()
        print(isPalindrome("racecar"))
        // Output: true
        
        print(isPalindrome("hello"))
        // Output: false
        
        print(isPalindrome("A man a plan a canal Panama"))
        // Output: true
        
        print(isPalindrome("DAD"))
        //  Output: true
    }
}
