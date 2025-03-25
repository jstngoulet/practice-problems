//
//  CurrencyConverter.swift
//
//
//  Created by Justin Goulet on 3/24/25.
//

import Foundation
/**
 Given a list of nodes for a currency conversion tool,
 determine the quickest conversion possible
 */
class CurrencyConverter: NSObject {
    var conversionMap: [(from: String, to: String, rate: Double)] = [
        ("US", "EN", 1.2),
        ("FR", "SP", 0.8),
        ("EU", "EN", 2.5),
        ("EN", "FR", 0.62),
        ("SP", "US", 0.115)
    ]
    
    let testCases: [(start: String, end: String, rate: Double)] = [
        ("US", "FR", 1.2 * 0.62),           // Expected path: US -> EN -> FR, Expected rate: 0.744
        ("FR", "US", 0.8 * 0.115),          // Expected path: FR -> SP -> US, Expected rate: 0.092
        ("EU", "SP", 2.5 * 0.62 * 0.8),     // Expected path: EU -> EN -> FR -> SP, Expected rate: 1.24
        ("SP", "EN", 0.115 * 1.2),          // Expected path: SP -> US -> EN, Expected rate: 0.138
        ("US", "EU", -1)                    // Expected: No conversion path found
    ]
    
    override init() {
        super.init()
        testCases.forEach {
            guard let result = mapCurrency(
                from: $0.start,
                to: $0.end,
                map: conversionMap
            ) else {
                print("No Map Found between: \($0.start) -> \($0.end)")
                return
            }
            let dataDict = [
                "start": $0.start,
                "end": $0.end,
                "rate": (result.rate * 100).rounded() / 100,
                "path": result.path ?? [],
                "rate_matches": $0.rate == result.rate
            ]
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        }
    }
    
    func mapCurrency(
        from start: String,
        to end: String,
        map: [(from: String, to: String, rate: Double)]
    ) -> (path: [String]?, rate: Double)? {
        
        //  Create the graph with the paths
        var graph: [String: [(symbol: String, rate: Double)]] = [:]
        
        //  Populate the graph with the edges
        for (start, end, rate) in map {
            graph[start, default: []].append((end, rate))
        }
        
        //  Create the path that we will be traversing, starting at the starting location
        //  then moving backwards
        //  Start the rate off at 1, as no conversion
        var traversed: [(symbol: String, path: [String], rate: Double)] = [(start, [start], 1.0)]
        var visitedPath: Set<String> = [start]
        
        while !traversed.isEmpty {
            
            let (symbol, path, rate) = traversed.removeFirst()
            
            if symbol == end {
                return (path, rate)
            }
            
            for (neighbor, conversionRate) in graph[symbol] ?? [] where !visitedPath.contains(neighbor) {
                visitedPath.insert(neighbor)
                traversed.append(
                    (
                        symbol: neighbor,
                        path: path + [neighbor],
                        rate: rate * conversionRate
                    )
                )
            }
            
        }
        
        //  No Path found
        return nil
    }
}
