import Foundation

class DeduplicateVendors: Problem {
    
    struct Vendor: Equatable, Hashable {
        let name: String
        let id: String
    }
    
    /**
     Removes duplicate vendors based on their name and tax ID, preserving the first occurrence.
    
     - Parameter vendors: An array of vendor tuples with (name, taxId).
     - Returns: A deduplicated array of vendors in the same order as the original, using both fields for comparison.
     */
    func uniqueVendors(_ vendors: [(String, String)]) -> [(String, String)] {
        let vendorList: [Vendor] = vendors.compactMap { Vendor(name: $0.0, id: $0.1) }
        var newVendors = [Vendor]()
        var seen: Set<Vendor> = []
        
        for vendor in vendorList {
            if !seen.contains(vendor) {
                newVendors.append(vendor)
                seen.insert(vendor)
            }
        }
        
        return newVendors.map({ ($0.name, $0.id )})
    }

    override func performTests() {
        print("Running tests for: DeduplicateVendors")

        struct TestCase {
            let input: [(String, String)]
            let expected: [(String, String)]
        }

        let tests: [TestCase] = [
            // Test 1: Exact duplicates
            TestCase(
                input: [("Acme", "111"), ("Acme", "111"), ("Acme", "111")],
                expected: [("Acme", "111")]
            ),

            // Test 2: Mixed vendors with shared names
            TestCase(
                input: [("Acme", "111"), ("Acme", "222"), ("Acme", "111")],
                expected: [("Acme", "111"), ("Acme", "222")]
            ),

            // Test 3: No duplicates
            TestCase(
                input: [("A", "1"), ("B", "2"), ("C", "3")],
                expected: [("A", "1"), ("B", "2"), ("C", "3")]
            ),

            // Test 4: Unordered duplicates
            TestCase(
                input: [("B", "2"), ("A", "1"), ("B", "2"), ("A", "1")],
                expected: [("B", "2"), ("A", "1")]
            ),

            // Test 5: Empty input
            TestCase(
                input: [],
                expected: []
            ),

            // Test 6: Same name, different tax IDs
            TestCase(
                input: [("X", "1"), ("X", "2"), ("X", "3")],
                expected: [("X", "1"), ("X", "2"), ("X", "3")]
            ),

            // Test 7: Long list with scattered duplicates
            TestCase(
                input: [
                    ("A", "1"), ("B", "2"), ("C", "3"),
                    ("A", "1"), ("D", "4"), ("C", "3"), ("E", "5"),
                ],
                expected: [
                    ("A", "1"), ("B", "2"), ("C", "3"), ("D", "4"), ("E", "5"),
                ]
            ),

            // Test 8: Similar name, different case (case sensitive)
            TestCase(
                input: [("acme", "123"), ("Acme", "123")],
                expected: [("acme", "123"), ("Acme", "123")]
            ),

            // Test 9: Vendors with same tax ID, different name
            TestCase(
                input: [("Foo", "999"), ("Bar", "999"), ("Foo", "999")],
                expected: [("Foo", "999"), ("Bar", "999")]
            ),

            // Test 10: Large number of unique vendors
            TestCase(
                input: (1...100).map { ("Vendor \($0)", "\($0)") },
                expected: (1...100).map { ("Vendor \($0)", "\($0)") }
            ),
        ]

        let header = [
            "Test#".padding(toLength: 6, withPad: " ", startingAt: 0),
            "Output".padding(toLength: 40, withPad: " ", startingAt: 0),
            "Expected".padding(toLength: 40, withPad: " ", startingAt: 0),
            "Pass",
        ].joined(separator: " | ")
        print(header)
        print(String(repeating: "-", count: header.count))

        for (i, test) in tests.enumerated() {
            let output = uniqueVendors(test.input)
            let pass = output.elementsEqual(test.expected, by: { $0 == $1 })
            let testNum = "\(i + 1)".padding(toLength: 6, withPad: " ", startingAt: 0)
            let outputStr = "\(output)".padding(toLength: 40, withPad: " ", startingAt: 0)
            let expectedStr = "\(test.expected)".padding(toLength: 40, withPad: " ", startingAt: 0)
            let passStr = pass ? "✅" : "❌"
            print("\(testNum) | \(outputStr) | \(expectedStr) | \(passStr)")
        }
    }
}
