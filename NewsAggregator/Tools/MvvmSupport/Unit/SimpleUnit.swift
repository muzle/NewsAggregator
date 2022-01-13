import Foundation

enum SimpleUnit<I, O, E>: UnitType {
    typealias Event = E
    typealias Input = I
    typealias Output = O
}
