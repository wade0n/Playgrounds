import Foundation

let q = DispatchQueue(label: "com.tech.test")

DispatchQueue.global(qos: .utility).async {
    print("A")
    DispatchQueue.main.async {
        print("B")
        DispatchQueue.main.async {
            print("C")
            q.async {
                q.sync {
                    print("D")
                }
            }
        }
        print("E")
    }
    
    print("F")
}


