
/**
### Problem: Currency Converter using Graphs

#### Description

You are tasked with building a currency converter system that can convert one currency into another. 
The system should be able to convert between various currencies given the exchange rates, which are 
provided in a graph-like structure.

Each currency is represented as a node in the graph, and there is a directed edge from one currency 
to another if there is an exchange rate available between those currencies. The weight of each edge 
represents the exchange rate from one currency to another.

Your task is to implement a function that can determine the exchange rate from one currency to another, 
either directly or through a series of intermediate currencies. The solution should be efficient and 
handle cases where there is no direct or indirect conversion available.

#### Input

1. **Currencies:** A list of currency names represented as strings.
2. **Exchange Rates:** A list of exchange rates between different currencies. Each exchange rate is 
represented as a tuple of three values:
   - `currency1`: The starting currency (source).
   - `currency2`: The destination currency (target).
   - `rate`: The exchange rate between `currency1` and `currency2` (where the rate represents how much 
   `currency2` you get for 1 unit of `currency1`).
3. **Convert:** A query that asks for the exchange rate between two currencies.

#### Output

- Return the exchange rate from `currency1` to `currency2`. If no conversion path exists, return `-1`.

#### Example:

**Input:**

```swift
let currencies = ["USD", "EUR", "GBP", "INR"]
let exchangeRates: [(String, String, Double)] = [
    ("USD", "EUR", 0.85),
    ("EUR", "GBP", 0.75),
    ("GBP", "INR", 100.0),
    ("USD", "INR", 75.0)
]
let startCurrency = "USD"
let endCurrency = "INR"
```

**Output:**

```swift
75.0
```

**Explanation:**

- The conversion from "USD" to "INR" can be directly achieved by using the exchange rate between USD and INR, which is 75.0.

**Example 2:**

**Input:**

```swift
let currencies = ["USD", "EUR", "GBP", "INR"]
let exchangeRates: [(String, String, Double)] = [
    ("USD", "EUR", 0.85),
    ("EUR", "GBP", 0.75),
    ("GBP", "INR", 100.0)
]
let startCurrency = "USD"
let endCurrency = "INR"
```

**Output:**

```swift
63.75
```

**Explanation:**

- The conversion from USD to INR can be achieved through the following chain:
  1. Convert from USD to EUR using the rate 0.85.
  2. Convert from EUR to GBP using the rate 0.75.
  3. Convert from GBP to INR using the rate 100.0.
  Resulting in 1 USD = 0.85 * 0.75 * 100 = 63.75 INR.

**Example 3:**

**Input:**

```swift
let currencies = ["USD", "EUR", "GBP", "INR"]
let exchangeRates: [(String, String, Double)] = [
    ("USD", "EUR", 0.85),
    ("EUR", "GBP", 0.75)
]
let startCurrency = "USD"
let endCurrency = "INR"
```

**Output:**

```swift
-1
```

**Explanation:**

- There is no direct or indirect conversion path from "USD" to "INR" because no exchange rate is 
provided between "INR" and the currencies in the graph.

#### Constraints:

- The number of currencies (nodes) will not exceed 100.
- The number of exchange rate pairs (edges) will not exceed 10,000.
- Exchange rates are positive floating-point numbers.
- If there is no path between the start and end currencies, return `-1`.

---

### Approach:

This problem can be solved using **graph traversal algorithms** such as **Depth-First Search (DFS)** 
or **Breadth-First Search (BFS)**. Each currency acts as a node, and the exchange rates act as weighted 
edges between the nodes. The goal is to traverse the graph to find the exchange rate from the start currency 
to the target currency.

### Solution Outline:

1. **Graph Representation**:
   - Represent the currencies and exchange rates as a graph where each currency is a node.
   - Each exchange rate between two currencies will be a directed edge with a weight corresponding to the exchange rate.
   
2. **Graph Traversal**:
   - Use BFS or DFS to find the path between the start currency and the end currency. Multiply the rates along the path.
   - If no path exists, return `-1`.

3. **Edge Case**:
   - Handle the case where the start and end currencies are the same by returning `1.0` (since no conversion is needed).
   
--- 

This problem tests your ability to work with graphs, perform efficient graph traversal, and deal with edge 
cases like non-connected components or cyclic graphs.
*/

import Foundation

class CurrencyConverter: Problem {
    
    struct Currency: Codable {
        var source: String
        var destination: String
        var rate: Double
    }
    
    override func performTests() {
        typealias TestCase = (map: [Currency], source: String, destination: String, expected: Double)
        let tests: [TestCase] = [
            (
                [
                    Currency(source: "USD", destination: "EUR", rate: 0.85),
                    Currency(source: "EUR", destination: "GBP", rate: 0.75),
                    Currency(source: "GBP", destination: "INR", rate: 100.0),
                    Currency(source: "USD", destination: "INR", rate: 75.0)
                ],
                "USD", "INR",
                75.0
            ), 
            (
                [
                    Currency(source: "US", destination: "EN", rate: 1.2),
                    Currency(source: "FR", destination: "SP", rate: 0.8),
                    Currency(source: "EU", destination: "EN", rate: 2.5),
                    Currency(source: "EN", destination: "FR", rate: 0.62),
                    Currency(source: "SP", destination: "US", rate: 0.115)
                ],
                "FR", "US", 0.8 * 0.115
            ), 
            (
                [
                    Currency(source: "US", destination: "EN", rate: 1.2),
                    Currency(source: "FR", destination: "SP", rate: 0.8),
                    Currency(source: "EU", destination: "EN", rate: 2.5),
                    Currency(source: "EN", destination: "FR", rate: 0.62),
                    Currency(source: "SP", destination: "US", rate: 0.115)
                ],
                "EU", "SP", 2.5 * 0.62 * 0.8
            ), 
            (
                [
                    Currency(source: "US", destination: "EN", rate: 1.2),
                    Currency(source: "FR", destination: "SP", rate: 0.8),
                    Currency(source: "EU", destination: "EN", rate: 2.5),
                    Currency(source: "EN", destination: "FR", rate: 0.62),
                    Currency(source: "SP", destination: "US", rate: 0.115)
                ],
                "SP", "EN", 0.115 * 1.2
            ), 
            (
                [
                    Currency(source: "US", destination: "EN", rate: 1.2),
                    Currency(source: "FR", destination: "SP", rate: 0.8),
                    Currency(source: "EU", destination: "EN", rate: 2.5),
                    Currency(source: "EN", destination: "FR", rate: 0.62),
                    Currency(source: "SP", destination: "US", rate: 0.115)
                ],
                "US", "EU", -1
            )
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = convertCurrency(from: test.source, to: test.destination, map: test.map)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")\t Result: \(result.roundNumber)\t\tExpected: \(test.expected.roundNumber)")
        }
    }
    
    func convertCurrency(from source: String, to destination: String, map: [Currency]) -> Double {
        
        if source == destination { return 1.0 }
        
        typealias DestinationCurrency = (dest: String, rate: Double)
        var currencyGraph: [String: [DestinationCurrency]] = [:]
        
        for currency in map {
            currencyGraph[currency.source, default: []] += [(currency.destination, currency.rate)]
        }
        
        var traversed: [(symbol: String, path: [String], rate: Double)] = [(source, [source], 1.0)] //  Create traversal at start
        var visitedPath: Set<String> = []  //  Kepp track of where we have been
        
        while !traversed.isEmpty {
            //  Remove the first and find the possible next steps
            let current = traversed.removeFirst()
            
            if current.symbol == destination {
                return current.rate
            }
            
            //  If not the same, loop through
            for (neighbor, conversionRate) in (currencyGraph[current.symbol] ?? []) 
                where !visitedPath.contains(neighbor) {
                visitedPath.insert(neighbor)
                traversed.append(
                    (
                        symbol: neighbor, 
                        path: current.path + [neighbor], 
                        rate: current.rate * conversionRate
                    )
                )
            }
        }
        
        //  Return nil when no possible path
        return -1
    }
}

extension Double {
    var roundNumber: Double {
        (self * 100).rounded() / 100
    }
}