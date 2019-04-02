/*:
 ## Exercise - Type Casting and Inspection
 
 Create a collection of type [Any], including a few doubles, integers, strings, and booleans within the collection. Print the contents of the collection.
 */
var anyCollection: [Any] = [2, "Moi", true]

anyCollection += [0.99]

/*:
 Loop through the collection. For each integer, print "The integer has a value of ", followed by the integer value. Repeat the steps for doubles, strings and booleans.
 */
for items in anyCollection {
    if let integers = items as? Int {
        print("The integer has a value of \(integers)")
    }
    if let doubles = items as? Double {
        print("The double has a value of \(doubles)")
    }
    if let strings = items as? String {
        print("The string has a value of \(strings)")
    }
    if let booleans = items as? Bool {
        print("The boolean has a value of \(booleans)")
    }
}

/*:
 Create a [String : Any] dictionary, where the values are a mixture of doubles, integers, strings, and booleans. Print the key/value pairs within the collection
 */
var anyDictionnary = [String : Any]()

anyDictionnary["Vrai"] = false
anyDictionnary["Deux"] = 3
anyDictionnary["Demi"] = 3.0
anyDictionnary["Mot"] = "Mot"

print(anyDictionnary)
/*:
 Create a variable `total` of type `Double` set to 0. Then loop through the dictionary, and add the value of each integer and double to your variable's value. For each string value, add 1 to the total. For each boolean, add 2 to the total if the boolean is `true`, or subtract 3 if it's `false`. Print the value of `total`.
 */
var total: Double = 0

for items in anyDictionnary.values {
    if let addingInt = items as? Int {
        total += Double(addingInt)
    }
    if let addingDouble = items as? Double {
        total += addingDouble
    }
    if items is String {
        total += 1
    }
    if let addingBoolean = items as? Bool {
        if addingBoolean == true {
            total += 2
        } else if addingBoolean == false {
            total += 3
        }
    }
}

print(total)

/*:
 Create a variable `total2` of type `Double` set to 0. Loop through the collection again, adding up all the integers and doubles. For each string that you come across during the loop, attempt to convert the string into a number, and add that value to the total. Ignore booleans. Print the total.
 */
var total2: Double = 0

for items in anyDictionnary.values {
    if let addInt = items as? Int {
        total2 += Double(addInt)
    }
    if let addDouble = items as? Double {
        total2 += addDouble
    }
    if items is String {
        total2 += 1
    }
}

print(total2)
//: page 1 of 2  |  [Next: App Exercise - Workout Types](@next)
