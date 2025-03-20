import UIKit


enum Optional<T> {
    case some(T)
    case none
}

extension Optional: Equatable where T: Equatable {
    func isEqual(lhs: Optional<T>, rhs: Optional<T>) -> Bool {
    switch (lhs, rhs){
      case (.some,.none),(.none, .some):
        return false
      case let (.some(lValue), .some(rValue)):
        return true
      default:
        return true
    }
  }
}

class SomeClass: Equatable {
    static func == (lhs: SomeClass, rhs: SomeClass) -> Bool {
           return true
       }
}

class AnotherClass {
  let a: () -> Void = {}
}

let a =  Optional<SomeClass>.some(SomeClass())
let b =  Optional<SomeClass>.none

let condition = a == b //false?

let c =  Optional<AnotherClass>.some(AnotherClass())
