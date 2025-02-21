import UIKit

class Super {
    
}

extension Super {
    internal class Some {
        var counter = 0
        
        var increment: () -> ()
        
        init(counter: Int = 0) {
            self.counter = counter
            self.increment =  { [weak self] in
                guard let self = self else { return }
                self.counter += 1
            }
        }
        
    }
}


let sup = Super.Some()
sup.increment()
print(sup.counter)
sup.increment()
print(sup.counter)
