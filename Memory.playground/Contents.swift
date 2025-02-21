import Foundation

// 1
func print(address obj: UnsafeRawPointer ) {
    print(String(format: "%p", Int(bitPattern: obj)))
}
//2
var array1: [Int] = [0, 1, 2, 3]
var array2 = array1
// 3
print(address: array1) //0x600000078de0
print(address: array2) //0x600000078de0

// 4
array2.append(4)
//5
print(address: array1) //0x600000078de0
print(address: array2) //0x6000000aa100

func address(_ object: UnsafeRawPointer) -> String {
    let address = Int(bitPattern: object)
    return NSString(format: "%p", address) as String
}


var dict1 = [0: "Boom", 1: "LOl"]
var dict2 = dict1

print("dictionaries")
address(&dict1)
address(&dict2)

print("Structures")
struct Contact {
    var name = "none"
}

var contactA = Contact()
var contactB = contactA

address(&contactA)
address(&contactB)

print("array of structs")
var arrayA = [Contact(name: "Ivan")]
var arrayB = arrayA
// 2
address(&arrayA)
address(&arrayB)
// 3
arrayB[0].name = "Petr"
// 4
print(arrayA[0].name)// Ivan
print(arrayB[0].name) // Petr
// 5
address(&arrayA)
address(&arrayB)

class Test {
    var counter = 0
}
