import Foundation

class SessionDurationBuckets: Problem {
    /**
     Categorizes session durations into predefined time buckets.
    
     - Parameter durations: A list of session durations in seconds.
     - Returns: A dictionary where the keys are bucket labels and values are counts of how many sessions fall in each bucket.
     */
    func bucketSessions(_ durations: [Int]) -> [String: Int] {        
        struct Bucket: Codable {
            let name: String
            let secondRange: ClosedRange<Int>
            
            func isPlacementBucket(for seconds: Int) -> Bool 
            { secondRange.contains(seconds) }
            
        }
        
        let buckets: [Bucket] = [
            Bucket(name: "0-5 sec", secondRange: 0...5),
            Bucket(name: "6-30 sec", secondRange: 6...30),
            Bucket(name: "31-60 sec", secondRange: 31...60),
            Bucket(name: "1-5 min", secondRange: 61...299),
            Bucket(name: "5+ min", secondRange: (5*60)...Int.max)
        ]
        
        func determineBucket(for seconds: Int, base: [Bucket]) -> Bucket? {
            for bucket in base {
                if bucket.isPlacementBucket(for: seconds) {
                    return bucket
                }
            }
            return nil
        }
        
        //  Now that the buckets and function is created, let's create our dict
        var baseDurations: [String: Int] = [:]
        
        //  Now, group based on the bucket
        for item in durations {
            if let bucketFound = determineBucket(for: item, base: buckets) {
                baseDurations[bucketFound.name, default: 0] += 1
            }
        }
        
        return baseDurations
    }

    override func performTests() {
        print("Running tests for: SessionDurationBuckets")

        struct TestCase {
            let input: [Int]
            let expected: [String: Int]
        }

        let tests: [TestCase] = [
            // Test 1: Mixed durations
            TestCase(
                input: [2, 12, 45, 90, 305, 360, 7, 5],
                expected: [
                    "0-5 sec": 2,
                    "6-30 sec": 2,
                    "31-60 sec": 1,
                    "1-5 min": 1,
                    "5+ min": 2,
                ]
            ),

            // Test 2: All in one bucket
            TestCase(
                input: [1, 2, 3, 4, 5],
                expected: ["0-5 sec": 5]
            ),

            // Test 3: Edge values
            TestCase(
                input: [5, 6, 30, 31, 60, 61, 300, 301],
                expected: [
                    "0-5 sec": 1,
                    "6-30 sec": 2,
                    "31-60 sec": 2,
                    "1-5 min": 1,
                    "5+ min": 2,
                ]
            ),

            // Test 4: Empty input
            TestCase(
                input: [],
                expected: [:]
            ),

            // Test 5: Large sessions only
            TestCase(
                input: [301, 999, 1200],
                expected: ["5+ min": 3]
            ),

            // Test 6: Single value per bucket
            TestCase(
                input: [1, 10, 40, 120, 400],
                expected: [
                    "0-5 sec": 1,
                    "6-30 sec": 1,
                    "31-60 sec": 1,
                    "1-5 min": 1,
                    "5+ min": 1,
                ]
            ),

            // Test 7: Negative values (invalid)
            TestCase(
                input: [-5, -1, 0, 3],
                expected: [
                    "0-5 sec": 2
                ]
            ),

            // Test 8: Durations exactly on edges
            TestCase(
                input: [5, 30, 60, 300],
                expected: [
                    "0-5 sec": 1,
                    "6-30 sec": 1,
                    "31-60 sec": 1,
                    "5+ min": 1,
                ]
            ),

            // Test 9: Floating point seconds (rounded down)
            TestCase(
                input: [5, 5.9, 30.1, 299.9, 300.1].map { Int($0) },
                expected: [
                    "0-5 sec": 2,
                    "6-30 sec": 1,
                    "1-5 min": 1,
                    "5+ min": 1,
                ]
            ),

            // Test 10: Very short durations only
            TestCase(
                input: [0, 0, 1],
                expected: ["0-5 sec": 3]
            ),
        ]

        let header = [
            "Test#".padding(toLength: 6, withPad: " ", startingAt: 0),
            "Output".padding(toLength: 60, withPad: " ", startingAt: 0),
            "Expected".padding(toLength: 60, withPad: " ", startingAt: 0),
            "Pass",
        ].joined(separator: " | ")
        print(header)
        print(String(repeating: "-", count: header.count))

        for (i, test) in tests.enumerated() {
            let output = bucketSessions(test.input)
            let outputSorted = output.sorted { $0.key < $1.key }
            let expectedSorted = test.expected.sorted { $0.key < $1.key }

            let pass = outputSorted.elementsEqual(
                expectedSorted, by: { $0.key == $1.key && $0.value == $1.value })

            let testNum = "\(i + 1)".padding(toLength: 6, withPad: " ", startingAt: 0)
            let outputStr = "\(output)".padding(toLength: 60, withPad: " ", startingAt: 0)
            let expectedStr = "\(test.expected)".padding(toLength: 60, withPad: " ", startingAt: 0)
            let passStr = pass ? "✅" : "❌"
            print("\(testNum) | \(outputStr) | \(expectedStr) | \(passStr)")
        }
    }
}
