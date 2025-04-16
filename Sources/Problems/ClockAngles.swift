
/**

### 🕰️ Swift Coding Challenge: Clock Angle Calculator

**Prompt:**  
Write a Swift function that takes a time string in 24-hour `"hh:mm"` format and returns the smallest 
angle (in degrees) between the hour and minute hands on an analog clock. Round the result to the nearest whole degree.

**Function Signature:**  
```swift
func clockAngle(at time: String) -> Int
```

**Examples:**
```swift
clockAngle(at: "03:00") // → 90
clockAngle(at: "12:30") // → 165
clockAngle(at: "00:00") // → 0
clockAngle(at: "18:00") // → 180
```

**Constraints:**
- Assume valid input between `"00:00"` and `"23:59"`.
- Return the **smallest** of the two possible angles (i.e., always ≤ 180°).

---

### 🌟 Bonus Question: Zero Hour
Determine all the times in a 12-hour period where the angle between the hour and minute hands is exactly 
**0 degrees**. How often does this occur in 24 hours? Output those times in `"hh:mm"` format.
*/
import Foundation

class ClockAngles: Problem {
    
    override func performTests() {
        typealias TestCase = (time: String, expected: Int)
        let tests: [TestCase] = [
            ("00:00", 0),
            ("03:00", 90),
            ("06:00", 180),
            ("09:00", 90),
            ("12:00", 0),
            ("12:30", 165),
            ("01:45", 143),
            ("23:59", 6),
            ("02:20", 50),
            ("18:00", 180),
            ("04:20", 10),
            ("10:10", 115),
            ("05:30", 15),
            ("11:59", 6),
            ("13:00", 30)  // 1 PM → 30°
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = clockAngle(at: test.time)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")\t\(test.time), \tE: \(test.expected)\tR: \(result)")
        }
        bonusQuestion()
    }
    
    func clockAngle(at: String) -> Int {
        
        let durationBreakdown = at.split(separator: ":")
        if durationBreakdown.count != 2 { return -1 }
        
        guard let hoursConvert = Int(durationBreakdown[0])
            , let minConvert = Int(durationBreakdown[1])
        else { return -1 } 
        
        //  Now, we need to get the hours and min mapped
        let hours = Double(hoursConvert % 12) //    Convert to clock
        let mins = Double(minConvert)
        
        let hourHandAngle = (30 * hours) + (mins * 0.5)
        let minHandAngle = (6 * mins)
        
        let angle = abs(hourHandAngle - minHandAngle)
        let smallestAngle = min(angle, 360 - angle)
        
        return Int(round(smallestAngle))
    }
    
    func bonusQuestion() {
        //  Check to see how many times the degree is zero, and count it
        var times: Set<String> = []
          
        for n in 0..<11 {
            let totalMinutes = (720.0 / 11.0) * Double(n)
            let hours = Int(totalMinutes) / 60
            let minutes = totalMinutes.truncatingRemainder(dividingBy: 60)

            let formatted = String(
                format: "%02d:%02d",
                hours == 0 ? 12 : hours,
                Int(round(minutes))
            )

            times.insert(formatted)
        }
        
        print("Times: \(times.count), clocked: \(times.description)")
        
    }
}  