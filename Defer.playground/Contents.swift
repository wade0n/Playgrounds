import UIKit

var greeting = "Hello, playground"


func getIndex() -> Int {
    var index = 1
     defer {
         index = 0
         print(index)
     }
     return index
}
let index = getIndex()
print(index) // 1

func f(x: Int) {
  defer { print("First defer") }


  if x < 10 {
    defer { print("Second defer") }
    print("End of if")
  }


  print("End of function")
}
f(x: 1)


func f() {
    defer { print("First defer") }
    defer { print("Second defer") }
    print("End of function")
}
f()


