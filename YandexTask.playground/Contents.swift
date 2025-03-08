import UIKit

let sarr = ["0:00", "0:00", "0"]
let timeStart = sarr[0]
let timeEnd = sarr[1]
let timeAdd = Int(sarr[2])!

func getTimeDuration(_ timeString: String) -> Int {
    let numbers = timeString.split(separator: ":")
    let hours = Int(numbers[0])!
    let minutes = Int(numbers[1])!
    return hours * 60 + minutes
}

func countFlightDuration(start: Int, finish: Int, timeShift: Int) -> String {
    var finish = finish - timeShift * 60
    let dif  =  finish  - start
    let duration = dif > 0 ? dif : dif + 24*60
    let hours = Int(duration / 60)
    let minutes = Int(duration % 60)
    return "\(hours):\(minutes < 10 ? "0" : "")\(minutes)"
}

func calculateFlightDuration(departure: String, arrival: String, timeZoneDifference: Int) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "H:mm"
    
    guard let departureTime = dateFormatter.date(from: departure),
          let arrivalTime = dateFormatter.date(from: arrival) else {
        return "Ошибка в формате времени"
    }
    
    let timeZoneOffset = TimeInterval(timeZoneDifference * 3600)
    let adjustedArrivalTime = arrivalTime.addingTimeInterval(-timeZoneOffset)
    
    var duration = adjustedArrivalTime.timeIntervalSince(departureTime)
    
    if duration < 0 {
        duration += 24 * 3600
    }
    
    let hours = Int(duration) / 3600
    let minutes = Int(duration) % 3600 / 60
    
    return String(format: "%d:%02d", hours, minutes)
}

//let start = getTimeDuration(timeStart)
//let end = getTimeDuration(timeEnd)
//print(countFlightDuration(start: start, finish: end, timeShift: timeAdd))
//print(calculateFlightDuration(departure: sarr[0], arrival: sarr[1], timeZoneDifference: timeAdd))




func sumOfUnique(_ values: [Int]) -> Int {
    var uniqueSet: Set<Int> = []
    var sum: Int = 0
    for value in values {
        if uniqueSet.contains(value) {
            continue
        } else {
            sum += value
            uniqueSet.insert(value)
        }
    }

    return sum
}


//print(sumOfUnique([3, 5, 4]))
//print(sumOfUnique([5, 5, 5]))
//print(sumOfUnique([7, 10, 3, 2, 7, 4, 8, 5, 9, 10]))

public class Node<T> {
    public var value: T
    public var next: Node<T>?
    
    public init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

struct Stack<T> {
    var storage: Node<T>? = nil
    var isEmpty: Bool {
        storage == nil
    }
    
    func peek() -> T? {
        storage?.value
    }
    mutating func pop() -> T? {
        
        defer {
            storage = storage?.next
        }
        
        let value = storage?.value
        return value
    }
    
    mutating func push(_ element: T) {
        let node = Node<T>.init(value: element, next: storage)
        storage = node
    }
}

func isValidBrackets(_ line: String) -> Bool {
    var stack = Stack<Character>()
    let openingBrackets: Set<Character> = ["(", "[", "{"]
    let closeBrackets: Set<Character> = [")", "]", "}"]
    
    func isCloseBracket(_ char: Character) -> Bool {
        closeBrackets.contains(char)
    }
    
    func isOpeningBracket(_ char: Character) -> Bool {
        openingBrackets.contains(char)
    }
    
    func isClosing(open: Character, close: Character) -> Bool {
        switch (open, close) {
        case ("(", ")"), ("[", "]"), ("{", "}"):
            return true
        default:
            return false
        }
    }

    for char in Array(line) {
        if isOpeningBracket(char) {
            stack.push(char)
        } else if isCloseBracket(char) {
            guard let openChar = stack.peek(), isClosing(open: openChar, close: char) else {
                return false
            }
            
            _ = stack.pop()
        }
    }
    
    return stack.isEmpty
}


//print(isValidBrackets("()"))
//print(isValidBrackets("()[]"))
//print(isValidBrackets("([)]"))
//print(isValidBrackets("("))
//print(isValidBrackets("(((())))"))


public class BTNode<T: Comparable> {
    var value: T
    var left: BTNode<T>?
    var right: BTNode<T>?
    
    init(_ value: T, leftNode: BTNode<T>? = nil, rightNode: BTNode<T>? = nil) {
        self.value = value
        self.left = leftNode
        self.right = rightNode
    }
    
    var min: BTNode<T>? {
        if left == nil {
            return self
        } else {
            return left!.min
        }
    }
}

public protocol BinaryTreeProtocol {
    associatedtype Value: Comparable
    
    var root: BTNode<Value>? { get set }
    
    func insert(_ value: Value) -> BTNode<Value>?
    func remove(_ value: Value) -> BTNode<Value>?
    func find(_ value: Value) -> BTNode<Value>?
    func findMin(node: BTNode<Value>?) -> BTNode<Value>?
    func findMax(node: BTNode<Value>?) -> BTNode<Value>?
    
    
    func printTree()
}

final class BinaryTree<T: Comparable>: BinaryTreeProtocol {
    typealias Value = T
    
    var root: BTNode<Value>?
    
    func insert(_ value: Value) -> BTNode<Value>? {
      guard let root = root else {
          self.root = BTNode(value)
          return self.root
        }
        
        var currentNode: BTNode<Value>? = root
        var previousNode: BTNode<Value> = root
        while (currentNode != nil) {
            if value < currentNode!.value {
                previousNode = currentNode!
                currentNode = currentNode!.left
            } else if value > currentNode!.value {
                previousNode = currentNode!
                currentNode = currentNode!.right
            } else {
                return currentNode
            }
        }
        
        let node = BTNode(value)
        
        if value < previousNode.value {
            previousNode.left = node
        } else if value > previousNode.value {
            previousNode.right = node
        }
        
        return node
    }
    
    func remove(_ value: Value) -> BTNode<Value>?  {
        guard let root = root else {
            self.root = BTNode(value)
            return self.root
          }
          
          var currentNode: BTNode<Value>? = root
          var previousNode: BTNode<Value> = root
          while (currentNode != nil) {
              if value < currentNode!.value {
                  previousNode = currentNode!
                  currentNode = currentNode!.left
              } else if value > currentNode!.value {
                  previousNode = currentNode!
                  currentNode = currentNode!.right
              } else {
                  deleteNode(currentNode!, previousNode: &previousNode)
              }
          }
          
        return nil
    }
    
    func find(_ value: Value) -> BTNode<Value>? {
        guard let root = root else {
            return nil
          }
          
          var currentNode: BTNode<Value>? = root
          var previousNode: BTNode<Value> = root
          while (currentNode != nil) {
              if value < currentNode!.value {
                  previousNode = currentNode!
                  currentNode = currentNode!.left
              } else if value > currentNode!.value {
                  previousNode = currentNode!
                  currentNode = currentNode!.right
              } else {
                  return currentNode
              }
          }
          
          return nil
    }
    
    func findMin(node: BTNode<Value>?) -> BTNode<Value>? {
        var node = node
        
        while node?.left != nil {
            node = node?.left
        }
        
        return node
    }
    func findMax(node: BTNode<Value>?) -> BTNode<Value>? {
        var node = node
        while node?.right != nil{
            node = node?.right
        }
        
        return node
    }
    
    func printTree() {
        var nodes = [root]
        
        while !nodes.isEmpty {
            var line: String = ""
            for counter in 0..<nodes.count {
                line += nodes[counter]?.value != nil ? "\(nodes[counter]!.value)" : "*"
                line += (counter + 1 < nodes.count ) ? " - " : ""
            }
            line += "\n"
            print(line)
            let nextLevelNodes: [BTNode<Value>?] = nodes.flatMap { [$0?.left, $0?.right] }
            nodes = nextLevelNodes.contains(where: { $0 != nil }) ? nextLevelNodes : []
        }
    }
    
    //MARK: - Private methods
    private func deleteNode(_ node: BTNode<Value>, previousNode: inout BTNode<Value>) {
        var newNode: BTNode<Value>?
        switch (node.left, node.right) {
        case (nil, nil):
            newNode = nil
        case (nil, let foundNode), (let foundNode, nil):
            newNode = foundNode
        case (let leftNode, var rightNode):
            let minRight = findMin(node: rightNode)
            newNode = node
            newNode?.value = minRight?.value ?? node.value
            
            deleteNode(minRight!, previousNode: &newNode!)
        }
        
        if node.value < previousNode.value {
            previousNode.left = newNode
        } else {
            previousNode.right = newNode
        }
    }
}

let tree = BinaryTree<Int>.init()

Dictionary

tree.insert(1)
tree.insert(2)
tree.insert(3)
tree.insert(8)
tree.insert(5)
tree.insert(6)
tree.insert(-1)
tree.insert(-4)
tree.insert(11)
tree.printTree()
tree.remove(5)
print("-----------------------------------------------")
tree.printTree()

