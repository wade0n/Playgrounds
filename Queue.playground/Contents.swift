import UIKit

var queue = DispatchQueue(label: "com.lol.wdfsd.lol", qos: .userInteractive, attributes: .concurrent)

print("Lol")

queue.async { [weak queue] in
    print("dsjandjknasd")
    queue?.sync {
        print("LOl")
    }
}


var array = [["a", "b"], ["2", "c"], ["4"], ["k", "l"]]

array.flatMap { $0 }.count
array.flatMap { $0 }.map { Int($0) }.count
array.flatMap { $0 }.compactMap { Int($0) }.count


protocol Animal {
   // func say()
}

extension Animal {
    func say() {
        print("Animal")
    }
}

class Cat: Animal {
    func say() {
        print("Cat")
    }
}

class Lion: Cat {
    override func say() {
        print("Lion")
    }
}

[Cat(), Cat() as? Animal, Lion() as? Animal].forEach { $0?.say() }

struct Person {
    let name: String
    //var neighbor: Person?
}






