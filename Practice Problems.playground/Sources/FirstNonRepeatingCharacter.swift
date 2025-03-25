//
//  FirstNonRepeatingCharacter.swift
//  
//
//  Created by Justin Goulet on 3/24/25.
//

import Foundation

class FirstNonRepeatingCharacter: NSObject {
    
    /**
     Problem: First Non-Repeating Character
     Difficulty: Beginner
     
     Description:
     Given a string, find the first non-repeating character and return it. If all characters repeat, return "None".
     
     Example:
     ```swift
     print(firstNonRepeatingCharacter("swiss"))  // Output: "w"
     print(firstNonRepeatingCharacter("racecar")) // Output: "e"
     print(firstNonRepeatingCharacter("aabb")) // Output: "None"
     print(firstNonRepeatingCharacter("abcdef")) // Output: "a"
     ```
     
     Function Signature:
     ```swift
     func firstNonRepeatingCharacter(_ str: String) -> String
     ```
     Hints:
     Use a dictionary to store the frequency of each character.
     Iterate through the string again to find the first character with a count of 1.
     ```
     */
    override init() {
        super.init()
        
        print(firstNonRepeatingCharacter("swiss"))  // Output: "w"
        print(firstNonRepeatingCharacter("racecar")) // Output: "e"
        print(firstNonRepeatingCharacter("aabb")) // Output: "None"
        print(firstNonRepeatingCharacter("abcdef")) // Output: "a"
        print(firstNonRepeatingCharacter("swiss"))   // Output: "w"
        print(firstNonRepeatingCharacter("racecar")) // Output: "e"
        print(firstNonRepeatingCharacter("aabb"))    // Output: "None"
        print(firstNonRepeatingCharacter("abcdef"))  // Output: "a"
        print(firstNonRepeatingCharacter("aabbccddeffg")) // Output: "g"
    }
    
    func firstNonRepeatingCharacter(_ str: String) -> String {
        var dictCount: [Character: Int] = [:]
        
        for char in str {
            dictCount[char, default: 0] += 1
        }
        
        //  Now, for each of the keys, find the first
        //  value with a 1
        for char in str where dictCount[char] == 1 {
            return String(char)
        }
        
        return "None"
    }
}
