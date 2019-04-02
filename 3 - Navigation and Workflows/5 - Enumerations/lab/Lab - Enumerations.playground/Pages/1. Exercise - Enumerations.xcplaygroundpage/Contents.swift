/*:
 ## Exercise - Enumerations
 
 Define a `Suit` enum with four possible cases: `clubs`, `spades`, `diamonds`, and `hearts`.
 */
enum Suit {
    case clubs, spades, diamonds, hearts
}

enum Value {
    case ace, two, three, four, five, six, seven, height, nine, ten, jack, queen, king
}
/*:
 Imagine you are being shown a card trick and have to draw a card and remember the suit. Create a variable instance of `Suit` called `cardInHand` and assign it to the `hearts` case. Print out the instance.
 */
var cardInHand = Suit.hearts
print(cardInHand)

/*:
 Now imagine you have to put back the card you drew and draw a different card. Update the variable to be a spade instead of a heart.
 */
cardInHand = .spades

/*:
 Imagine you are writing an app that will display a fun fortune (i.e. something like "You will soon find what you seek.") based on cards drawn. Write a function called `getFortune(cardSuit:)` that takes a parameter of type `Suit`. Inside the body of the function, write a switch statement based on the value of `cardSuit`. Print a different fortune for each `Suit` value. Call the function a few times, passing in different values for `cardSuit` each time.
 */
func getFortune(cardSuit: Suit) {
    switch cardSuit {
    case .spades:
        print("You are going to die.")
    case .diamonds:
        print("Pay attention to your surroundings.")
    case .hearts:
        print("No love in perspective.")
    case .clubs:
        print("Good luck with what is to come.")
    }
}

getFortune(cardSuit: .clubs)
getFortune(cardSuit: .diamonds)
getFortune(cardSuit: .hearts)
getFortune(cardSuit: .spades)


/*:
 How many values can playing cards have? How many values can `Int` be? It would be safer to have an enum for the card's value as well. Inside the struct above, create an enum for `Value`. It should have cases for `ace`, `two`, `three`, `four`, `five`, `six`, `seven`, `eight`, `nine`, `ten`, `jack`, `queen`, `king`. Change the type of `value` from `Int` to `Value`. Initialize two `Card` objects and print a statement for each that details the card's value and suit.
 */
struct Card {
    var shape: Suit
    var value: Value
    
    func description() {
        print("The card is a \(value) of \(shape).")
    }
}

var myDeck: [Card] = [Card(shape: .diamonds, value: .five)]
myDeck += [Card(shape: .diamonds, value: .king), Card(shape: .hearts, value: .queen), Card(shape: .spades, value: .ace)]

for card in myDeck {
    card.description()
}

//: page 1 of 2  |  [Next: App Exercise - Swimming Workouts](@next)
