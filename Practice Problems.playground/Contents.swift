import Foundation
import PlaygroundSupport

class DriverApplication: NSObject {
    override init() { super.init(); performTests() }
    
    func performTests() { }
}

DriverApplication()
PlaygroundPage.current.needsIndefiniteExecution = true
