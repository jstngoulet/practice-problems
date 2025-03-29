//
//  SongOrdering.swift
//  
//
//  Created by Justin Goulet on 3/26/25.
//

import Foundation

class SongOrdering: NSObject {
    
    /**
     This problem was asked by Spotify.
     
     You have access to ranked lists of songs for various users. Each song is represented as an integer, and more preferred songs appear earlier in each list. For example, the list [4, 1, 7] indicates that a user likes song 4 the best, followed by songs 1 and 7.
     
     Given a set of these ranked lists, interleave them to create a playlist that satisfies everyone's priorities.
     
     For example, suppose your input is {[1, 7, 3], [2, 1, 6, 7, 9], [3, 9, 5]}.
     In this case a satisfactory playlist could be [2, 1, 6, 7, 3, 9, 5].
     */
    typealias TestCase = (input: [[Int]], expected: [Int])
    func performTests() {
        let tests: [TestCase] = [
            // Basic test case with interleaving
            (input: [[1, 7, 3], [2, 1, 6, 7, 9], [3, 9, 5]],
             expected: [1, 7, 3, 2, 6, 9, 5]),
            
            // Single user playlist (should return as is)
            (input: [[4, 2, 8, 5]],
             expected: [4, 2, 8, 5]),
            
            // Multiple lists, no overlapping songs
            (input: [[1, 2, 3], [4, 5, 6], [7, 8, 9]],
             expected: [1, 4, 7, 2, 5, 8, 3, 6, 9]),
            
            // Multiple lists with duplicate songs
            (input: [[1, 2, 3], [3, 1, 4], [2, 3, 5]],
             expected: [1, 2, 3, 4, 5]),
            
            // One empty playlist, others populated
            (input: [[], [2, 4, 6], [1, 3, 5]],
             expected: [2, 1, 4, 3, 6, 5]),
            
            // All empty playlists (should return empty)
            (input: [[], [], []],
             expected: []),
            
            // Playlists with the same song order
            (input: [[1, 2, 3], [1, 2, 3], [1, 2, 3]],
             expected: [1, 2, 3]),
            
            // Large dataset to test performance
            (input: [
                Array(1...100),
                Array(stride(from: 50, to: 150, by: 2)),
                Array(75...125)
            ],
             expected: Array(Set(Array(1...100) + Array(stride(from: 50, to: 150, by: 2)) + Array(75...125))).sorted())
        ]
        for (index, testCase) in tests.enumerated() {
            runThroughTests(testCase: testCase, index: index, with: interleaveSongLists(_:), caller: "Me")
            runThroughTests(testCase: testCase, index: index, with: interleaveSongListsGiven(_:), caller: "Them")
        }
    }
    
    func runThroughTests(testCase: TestCase, index: Int, with inputFunction: @escaping (_ data: [[Int]]) -> [Int], caller: String = #function) {
        let output = inputFunction(testCase.input)
        let passed = output == testCase.expected
        print("\(caller): Test Case \(index + 1):", passed ? "✅ Passed" : "❌ Failed")
        if !passed {
            print("  Input: \(testCase.input)")
            print("  Expected: \(testCase.expected)")
            print("  Got: \(output)\n")
        }
    }
    
    func interleaveSongLists(_ lists: [[Int]]) -> [Int] {
        var maxLength: Int = 0
        var prioritizedRank: [Int: (occurances: Int, priorities: [Int])] = [:]
        
        //  Get the max length and fill in the song priority list
        for list in lists {
            maxLength = max(maxLength, list.count)
            
            //  Now, we sorted them by ranking
            for (iter, song) in list.enumerated() {
                if var songExistingData = prioritizedRank[song] {
                    prioritizedRank[song] = (songExistingData.occurances + 1, songExistingData.priorities + [iter + 1])
                } else {
                    prioritizedRank[song] = (1, [iter + 1])
                }
            }
        }
        
        //  Now, sort by priorituie then occurance
        let ordered = prioritizedRank.sorted(by: { lhs, rhs in
            
            //  We want to consider the priorty and the occuances in our ranking
            //  So, we will look at the priorty and multiply it by occurances
            //  Smaller priority means higher up
            let occurancesLh = lhs.value.occurances
            let prioritiesLh = lhs.value.priorities.reduce(1, *)
            
            let occurancesRh = rhs.value.occurances
            let prioritiesRh = rhs.value.priorities.reduce(1, *)
            //            return (occurancesLh * prioritiesLh) < (occurancesRh * prioritiesRh)
            return (prioritiesLh < prioritiesRh) && (occurancesLh > occurancesRh)
        })
        
        //  Now, sort the set based on the rankings and return
        return ordered.map({ $0.key })
    }
    
    /**
     Provided answer
     */
    func interleaveSongListsGiven(_ input: [[Int]]) -> [Int] {
        
        //  Will be the queue for all songs that need to be added
        var userList: [[Int]] = input
        var visitedSongs: Set<Int> = []
        var newPlaylist: [Int] = []
        
        while !userList.isEmpty {
            
            //  While the user list is not empty, keep iterating through
            //  and removing the next item in teh queue for each list
            var currentQueue: [[Int]] = []
            
            //  Now, for each list, iterate through and grab songs as they appear
            for var list in userList {
                //  Check the current list and remove the current items
                while !list.isEmpty, visitedSongs.contains(list[0]) {
                    list.removeFirst()  //  Skip added songs
                }
                
                if !list.isEmpty {
                    let song = list.removeFirst()
                    visitedSongs.insert(song)
                    newPlaylist.append(song)
                }
                
                if !list.isEmpty {
                    currentQueue.append(list)
                }
            }
            
            //  Reset the userList for next iteration
            userList = currentQueue
        }
        
        return newPlaylist
    }
}
