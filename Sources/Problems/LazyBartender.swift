import Foundation

class LazyBartender: Problem {
    /**
     Returns the minimum number of drink types the bartender needs to memorize
     in order to satisfy all customers, each with their own drink preferences.
    
     - Parameter preferences: A dictionary where each key is a customer ID and each value is an array of preferred drink IDs.
     - Returns: The minimum number of drinks required to satisfy all customers.
     */
    func minDrinks(_ preferences: [Int: [Int]]) -> Int {
        if preferences.isEmpty { return 0 }
        
        /**
            Walkthrough:

            Given a customer to drink dictionary, we need to know the minimum number of drinks
            Needed to make everyone happy.
            This is done by the given dict (sample):

            let preferences: [Int: [Int]] = [
                0: [0, 1, 3, 6],
                1: [1, 4, 7],
                2: [2, 4, 7, 5],
                3: [3, 2, 5],
                4: [5, 8]
            ]

            In the object, we see that customer 0 wants drinks 0, 1, 3, 6. That is our starting point
            Now, say another customer wants 1, 4, 7. 
            This means that as of now, we need to make at least drink 1, because that is where the lists intersect
            Our new list is [1], just reduced from 0, 1, 3, 6.
            Now, our 3rd customer wants 2, 4, 7, 5
            Uh oh. those are all new drinks. How do we know? each number in this list does not yet exist (the list is just 1)
                We iterated though the current list and previous and didnt find anything. Now, what about the first list. Are 
                there any intersections there?
                
            - Note - Sounds like we need an intersection function that takes in 2 arrays and spits out the intersection of
                both.
            
            Ok; Now, our new array is going to be [1] + [something]
            The something is because we don't know what other drink we need to make is yet. 
            We do know that we want the drink with the most coverage. 
                Coverage is the number of times that a drink appears in other peoples list.
            
            - Note - That means that we need to have a refernce into the drink count, similar to what we have for the order count
            
            In order to get the max, we can call a function to sort the list based on drink counts, and grab the first one
            that is within the user's preferences
            In order to do this, we need the counts for every drink in the list, then just return the max
            
        */
        
        func intersected(_ ar1: [Int], _ ar2: [Int]) -> [Int] {
            return ar1.filter({ ar2.contains($0) })
        }
        
        func getMaxDrink(from list: [Int], reference: [Int: Int]) -> Int {
            let availableDrinks: [Int] = intersected(list, (reference.keys.compactMap({ $0 })))
            var currentMaxDrink: Int = 0
            var currentMaxCount: Int = 0
            
            for drink in availableDrinks {
                if let currentDrinkCount = reference[drink]
                , currentDrinkCount > currentMaxCount {
                    currentMaxCount = currentDrinkCount
                    currentMaxDrink = drink
                }
            }
            
            return currentMaxDrink
        }
        
        var drinkReference: [Int: Int] = [:]  //  Drink #, Count
        var currentCustomer: Int = 0
        var drinksToLearn: Set<Int> = []
        
        for customer in preferences.keys {
            for drinkId in preferences[customer] ?? [] {
                drinkReference[drinkId, default: 0] += 1    //  Just the drink counts
            }
        }
        
        while let customerPrefernces = preferences[currentCustomer] {
            
            let intersectedDrinks: [Int] = intersected(Array(drinksToLearn), customerPrefernces)
            
            //  If intersection is empty, add the most common from preferences
            if intersectedDrinks.isEmpty {
                let learnDrink = getMaxDrink(
                    from: customerPrefernces, 
                    reference: drinkReference
                )
                drinksToLearn.insert(learnDrink)
            }
            
            currentCustomer += 1
        }
        
        return drinksToLearn.count
    }

    override func performTests() {
        print("Running tests for: \(type(of: self))\n")

        struct TestCase {
            let preferences: [Int: [Int]]
            let expected: Int
        }

        let tests: [TestCase] = [
            // Base example
            TestCase(
                preferences: [
                    0: [0, 1, 3, 6],
                    1: [1, 4, 7],
                    2: [2, 4, 7, 5],
                    3: [3, 2, 5],
                    4: [5, 8],
                ], expected: 2),

            // One customer, one drink
            TestCase(preferences: [0: [2]], expected: 1),

            // // All share the same drink
            TestCase(
                preferences: [
                    0: [1], 1: [1], 2: [1], 3: [1],
                ], expected: 1),

            // // No overlapping drinks
            TestCase(
                preferences: [
                    0: [0], 1: [1], 2: [2],
                ], expected: 3),

            // // Optimal subset
            TestCase(
                preferences: [
                    0: [1, 2], 1: [2, 3], 2: [1, 3],
                ], expected: 2),

            // // Multiple valid answers
            TestCase(
                preferences: [
                    0: [1, 2], 1: [2, 3], 2: [3, 4], 3: [4, 5],
                ], expected: 3),
        ]

        let header = "| Test # | Input Preferences                        | Expected | Actual | Pass |"
        let divider = String(repeating: "-", count: header.count)
        print(header)
        print(divider)

        for (i, test) in tests.enumerated() {
            let result = minDrinks(test.preferences)
            let pass = result == test.expected ? "✅" : "❌"
            let inputDesc = "\(test.preferences)".padding(toLength: 40, withPad: " ", startingAt: 0)
            let expectedStr = "\(test.expected)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let actualStr = "\(result)".padding(toLength: 6, withPad: " ", startingAt: 0)
            print(
                "| \(String(format: "%-6d", i + 1)) | \(inputDesc) | \(expectedStr) | \(actualStr) | \(pass) |"
            )
        }
    }
}
