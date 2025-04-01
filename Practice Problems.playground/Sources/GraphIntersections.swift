//
//  GraphIntersections.swift
//  
//
//  Created by Justin Goulet on 3/31/25.
//
import Foundation

class GraphIntersections: NSObject {
    
    override init() { super.init(); performTests() }
    func performTests() {
        typealias TestCase = (itemCount: Int, points: [Int], directions: String, expected: Int)
        let tests: [TestCase] = [
            (9, [6, 3, 4, 5, 1, 6, 3, 3, 4], "ULDRULURD", 4),
            (8, [1, 1, 1, 1, 1, 1, 1, 1], "RDLUULDR", 1),
            (8, [1, 2, 2, 1, 1, 2, 2, 1], "UDUDLRLR", 1)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = getPlusSignCount(test.0, test.1, test.2)
            let isPassed = result == test.3
            print("Test \(iter + 1): Passed: \(isPassed) - \(result) (\(test.3))")
        }
    }
    
    // Write any import statements here
    
    func getPlusSignCount(_ N: Int, _ L: [Int], _ D: String) -> Int {
        
        enum Direction: Character {
            case up       = "U"
            case down     = "D"
            case `left`   = "L"
            case `right`  = "R"
        }
        
        enum LineDirection: String {
            case horizontal
            case vertical
            case unknown
        }
        
        struct Coordinate: Hashable {
            var x: Int, y: Int
            
            var dict: [String: Any] {
                ["x": x, "y": y]
            }
        }
        
        struct Line: Hashable {
            let point1: Coordinate
            let point2: Coordinate
            
            //  Only say v or h
            var direction: LineDirection {
                if point1.x == point2.x { return .vertical }
                else if point1.y == point2.y { return .horizontal }
                else { return .unknown }
            }
            
            var dict: [String: Any] {[
                "point1": point1.dict,
                "point2": point2.dict,
                "direction: ": "\(direction)"
            ]}
            
            var pointDescription: String {
                "Start: (\(point1.x), \(point1.y)) -> End: (\(point2.x), \(point2.y)) :: \(direction.rawValue)"
            }
            
            //  Determine if the lines intersect safely
            //  Note: Dpes not intersect if edge of line crosses over.
            //  must be clean (edges cannot just be touching)
            func doesIntersect(_ line: Line) -> Bool {
                //  Lines intersect if the y on the vertical line crosses
                //  On the line between the 2 x's.
                //  So, the y, must be between the 2 x values
                //  AND the y value must be greater AND less than
                //  the x values
                let currentDirection = self.direction
                let otherDirection = line.direction
                
                if currentDirection == otherDirection {
                    return false // Same direction, parallel
                }
                
                //  Now, determine horizontal and vertical
                let hLine = currentDirection == .vertical ? line : self
                let vLine = currentDirection == .horizontal ? line : self
                
                let leftPointX = min(hLine.point1.x, hLine.point2.x)
                let rightPointX = max(hLine.point1.x, hLine.point2.x)
                
                //  Now, v line x must be between left and right point
                let vLineBetweenVBounds = vLine.point1.x > leftPointX && vLine.point1.x < rightPointX
                
                //  Now, the lowest point on V line must be greater than the lowest y on the H Line
                //  and th highest point on V line must be lower than the highest y on H Line
                //  The y on the H line is the sme
                let highestPointY = max(vLine.point1.y, vLine.point2.y)
                let lowestPointY = min(vLine.point1.y, vLine.point2.y)
                
                let vLineBetweenBounds = hLine.point1.y > lowestPointY && hLine.point1.y < highestPointY
                
                return vLineBetweenVBounds && vLineBetweenBounds
            }
        }
        
        //  start in 0 due to instructions
        var currentCoordinate: Coordinate = Coordinate(x: 0, y: 0)
        var currentLines: [Line] = []
        var currentIntersections: Int = 0
        let directionArray: [Character] = Array(D)
        
        for (iter, point) in L.enumerated() {
            //  For every point, check the direcxtion
            //  And add the line appropriately
            guard let dir = Direction(rawValue: directionArray[iter])
            else { continue } //  Break out if not valid
            
            var newCoordinate = currentCoordinate
            
            //  Now that we have direction, let's move the point accordingly
            if [.right, .left].contains(dir) {
                newCoordinate.x += point * ((dir == .left) ? -1 : 1)
            } else if [.up, .down].contains(dir) {
                newCoordinate.y += point * ((dir == .up) ? 1 : -1)
            }
            
            //  Add a new line
            currentLines += [Line(point1: currentCoordinate, point2: newCoordinate)]
            currentCoordinate = newCoordinate
        }
        
        //  Now, for every line, determine if they intersect
        let horizontalLines = currentLines.filter({$0.direction == .horizontal})
        let verticalLines = currentLines.filter({$0.direction == .vertical})
        
        //  Before we check, we need to merge lines
        func mergeH(lines: [Line]) -> [Line] {
            //  Following previous challenge, merge the groups
            guard !lines.isEmpty,
                  !lines.map({$0.direction}).contains(.vertical)
            else { return [] }
            var currentLines: [Int: [Int]] = [:]  // Y value, x values
            
            for line in lines {
                currentLines[line.point1.y, default: []] += [line.point1.x, line.point2.x]
            }
            //  For all the y values, get the min and max
            var formedLines: [Line] = currentLines.keys.compactMap { y in
                guard let minX = currentLines[y]?.min(),
                      let maxX = currentLines[y]?.max()
                else { return nil }
                
                return Line(point1: Coordinate(x: minX, y: y),
                            point2: Coordinate(x: maxX, y: y))
            }
            return formedLines
        }
        
        //  Before we check, we need to merge lines
        func mergeV(lines: [Line]) -> [Line] {
            //  Following previous challenge, merge the groups
            guard !lines.isEmpty,
                  !lines.map({$0.direction}).contains(.horizontal)
            else { return [] }
            var currentLines: [Int: [Int]] = [:]  // X value, Y values
            
            for line in lines {
                currentLines[line.point1.x, default: []] += [line.point1.y, line.point2.y]
            }
            //  For all the y values, get the min and max
            var formedLines: [Line] = currentLines.keys.compactMap { x in
                guard let minY = currentLines[x]?.min(),
                      let maxY = currentLines[x]?.max()
                else { return nil }
                
                return Line(point1: Coordinate(x: x, y: minY),
                            point2: Coordinate(x: x, y: maxY))
            }
            return formedLines
        }
        
        //  Check lines
        for hLine in mergeH(lines: horizontalLines) {
            for vLine in mergeV(lines: verticalLines) {
                currentIntersections += hLine.doesIntersect(vLine) ? 1 : 0
            }
        }
        
        return currentIntersections
    }
}
