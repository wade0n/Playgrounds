import Foundation

final class BTNode {
    var value: Int
    var duplicates: Int = 0
    var left: BTNode?
    var right: BTNode?
    weak var parent: BTNode?
    
    init(_ value: Int) {
        self.value = value
    }
    
    var min: Int {
        
        if let left = left {
            return left.min < value ? left.min : value
        }
        
        return value
    }
    
    var max: Int {
        if let right = right {
            return right.min > value ? right.min : value
        }
        
        return value
    }
}

public class Node<T> {
    public var value: T
    public var previous: Node<T>?
    public var next: Node<T>?

    
    public init(value: T, previous: Node<T>? = nil, next: Node<T>? = nil) {
        self.value = value
        self.previous = previous
        self.next = next
    }
    
    func printForward() {
        var current: Node<T>? = self
        var result: [T] = []
        while let node = current {
            result.append(node.value)
            current = node.next
        }
        print(result)
    }
    
    func printBackwards() {
        var current: Node<T>? = self
        var result: [T] = []
        while let node = current {
            result.append(node.value)
            current = node.previous
        }
        print(result)
    }
}

final class BST {
    var root: BTNode? = nil
    
    func printTree() {
        var nodes = [root]
        let depth = findDepth()
        
        var currentDepth: Int = 1
        var width: Int = Int(pow(Double(2), Double(depth))) - 1
        print("Width - \(width)")
        while !nodes.isEmpty {
            var line: String = ""
            for counter in 0..<nodes.count {
                line += nodes[counter]?.value != nil ? "\(nodes[counter]?.value ?? 0)" : "*"
                line += (counter + 1 < nodes.count ) ? " - " : ""
            }
            let offset = width - line.count/2 > 0 ? width - line.count/2 : 0
            line = String(repeating: " ", count: offset) + line
            line += "\n"
            print(line)
            let nextLevelNodes: [BTNode?] = nodes.flatMap { [$0?.left, $0?.right] }
            nodes = nextLevelNodes.contains(where: { $0 != nil }) ? nextLevelNodes : []
            currentDepth += 1
        }
    }
    
    func insert(_ value: Int) -> BTNode {
      guard let root = root else {
          self.root = BTNode(value)
          return self.root!
        }
        
        var currentNode: BTNode? = root
        var previousNode: BTNode = root
        while (currentNode != nil) {
            if value < currentNode!.value {
                previousNode = currentNode!
                currentNode = currentNode!.left
            } else if value >= currentNode!.value {
                previousNode = currentNode!
                currentNode = currentNode!.right
            }
        }
        
        let node = BTNode(value)
        
        if value < previousNode.value {
            previousNode.left = node
        } else if value >= previousNode.value {
            previousNode.right = node
        }
        node.parent = previousNode
        return node
    }
    
    /// O(log2(N))
    func findMin(node: BTNode?) -> BTNode? {
        var node = node
        
        while node?.left != nil {
            node = node?.left
        }
        
        return node
    }
    
    /// O(log2(N))
    func findMax(node: BTNode?) -> BTNode? {
        var node = node
        while node?.right != nil{
            node = node?.right
        }
        
        return node
    }
    
    func remove(node: BTNode) {
        var newNode: BTNode?
        
        //print("delete \(node.value)")
        switch (node.left, node.right) {
        case (nil, nil):
            newNode = nil
        case (nil, let foundNode), (let foundNode, nil):
            newNode = foundNode
        case (let leftNode, var rightNode):
            let minRight = findMin(node: rightNode)
            newNode = node
            newNode?.value = minRight?.value ?? node.value
            
            remove(node: minRight!)
        }
        
        guard let previousNode = node.parent else {
            self.root = newNode
            return
        }
        
        //print("previous \(previousNode.value), \(newNode)")
        if node.value < previousNode.value {
            previousNode.left = newNode
        } else {
            previousNode.right = newNode
        }
    }
    
    private func findDepth() -> Int {
        var maxDepth: Int = 0
        
        guard let root else {
            return maxDepth
        }
        
        var nodes =  [root]
        
        while !nodes.isEmpty {
            maxDepth += 1
            var nextNodes = [BTNode]()
            for node in nodes {
                if let leftNode = node.left {
                    nextNodes.append(leftNode)
                }
                if let rightNode = node.right {
                    nextNodes.append(rightNode)
                }
            }
            
            nodes = nextNodes
        }
        
        return maxDepth
    }
}

final class Deque {
    let tree: BST = .init()
    var first: Node<BTNode>? = nil
    var last: Node<BTNode>? = nil
    
    private var minCaptured: Int?
    
    var  min: Int? {
        if minCaptured == nil {
            minCaptured = tree.root?.min ?? nil
        }
        
        return minCaptured
    }
    
    init(array: [Int]) {
        var previousNode : BTNode? = nil
        var listValue: Node<BTNode>? = nil
        
        var minLocal: Int = Int.max
        for element in array {
            let node = tree.insert(element)
            
            let linkedNode = Node(value: node)
            listValue?.next = linkedNode
            linkedNode.previous = listValue
            
            if first == nil {
                first = listValue
            }
            
            previousNode = node
            listValue = linkedNode
            
            
            minLocal = Swift.min(minLocal, element)
        }
        
        minCaptured = minLocal
        last = listValue
        tree.printTree()
    }
    
    func insert(newValue: Int) {
        //print("new value - \(newValue)")
        // Add new.
        let newNode = tree.insert(newValue)
        let newListNode = Node(value: newNode)
        newListNode.next = first
        first?.previous = newListNode
        
        first = newListNode
        
        print("new value - \(newValue), min - \(minCaptured ?? Int.max)")
        
        minCaptured = Swift.min(minCaptured ?? Int.max, newValue)
        
        print("new value - \(newValue), min - \(minCaptured ?? Int.max)")
        /// Delete last element.
        print("last \(last!.value.value), parent \(last!.previous!.value.value)")
        if let last {
            print("last - \(last.value.value), min - \(minCaptured ?? Int.max)")
            if last.value.value == minCaptured ?? Int.max, last.value.value < newValue {
                minCaptured = nil
            }
            tree.remove(node: last.value)
            self.last = last.previous
            self.last?.next = nil
        }
        
        tree.printTree()
    }
}

class DequeList {
    var first: Node<Int>? = nil
    var last: Node<Int>? = nil
    
    var minCaptured: Int? = nil
    
    var minValue: Int {
        minCaptured ?? calculateMin()
    }
    
    init(array: [Int]) {
        
        var previous: Node<Int>? = nil
        var minimumValue = Int.max
        for index in 1...array.count {
            let value = array[array.count - index]
            let node = Node<Int>(value: value)
            
            if first == nil {
                self.first = node
            }
            
            previous?.next = node
            node.previous = previous
            
            previous = node
            minimumValue = min(minimumValue, value)
        }
        
        self.minCaptured = minimumValue
        self.last = previous
        self.first?.previous = nil
        //self.first?.printForward()
    }
    
    func insertAndPop(_ value: Int) {
        guard first?.next != nil else {
            first = Node<Int>(value: value)
            minCaptured = value
            return
        }
        /// 1. Capture initial values.
        let deleteValue = last?.value
        let currentMinValue = minValue
        /// 2. Delete last.
        last = last?.previous
        last?.next = nil
        /// 3. Insert New.
        let newNode = Node<Int>(value: value)
        newNode.next = first
        first?.previous = newNode
        first = newNode
        //print("currentMinValue: \(currentMinValue), value: \(value), deleteValue: \(deleteValue)")
        /// 4. Check for update min.
        if currentMinValue > value {
            minCaptured = value
        } else if currentMinValue == deleteValue {
            minCaptured = nil
        }
        
    }
    
    // TODO: - private methods.
    
    func calculateMin() -> Int {
        var node: Node<Int>? = first
        var minValue: Int = Int.max
        while node != nil {
            minValue = min(minValue, node!.value)
            node = node?.next
        }
        return minValue
    }
}


func printMinInList(arr: [Int], maskCount: Int) {
    print("Start \(Date())")
    let deque = DequeList(array: Array(arr[0..<maskCount]))
    print(deque.minValue)
    
    for i in maskCount..<arr.count {
        deque.insertAndPop(arr[i])
       // print(deque.minValue)
    }
    print("End \(Date())")
}

func printRMQ(arr: [Int], maskCount: Int) {
    let count = arr.count
    
    var forwardArr = [Int](repeating: Int.max, count: count)
    var backwardArr = forwardArr
    backwardArr[count-1] = arr[count-1]
    for index in 0..<count {
        print(index)
        if(index % maskCount != 0) {
            forwardArr[index] =  min(arr[index], forwardArr[index-1])
        } else {
            forwardArr[index] = arr[index]
        }
        
        if index == 0 {
            continue
        }
        
        
        let backwardCount = count - index - 1
        
        if (backwardCount % maskCount != 0) {
            backwardArr[backwardCount] =  min(arr[backwardCount], backwardArr[backwardCount+1])
        } else {
            backwardArr[backwardCount] = arr[backwardCount]
        }
    }
    for i in 0..<(count - maskCount+1) {
        print(min(backwardArr[i], forwardArr[i+maskCount-1]))
    }
}


//printMinInMask(arr: [1000, 3, 3, 1000, 3, 4, 5, 3, 5, 1000, 1000, 3, 3, 1000, 3, 4, 5, 3, 5, 1000, 1000, 3, 3, 1000, 3, 4, 5, 3, 5, 1000,1000, 3, 3], maskCount: 2)
//printMinInList(arr: [
//    1000, 3, 3, 1000, 3, 4, 5, 3, 5, 1000,
//    1000, 300, 3, 34 , 4, 6, 4, 2, 43, 4,
//    1000, 3, 3, 1000, 3, 4, 5, 3, 5, 1000,
//    1000, 3, 3, 1000, 3, 4, 5, 3, 5, 1000,
//    1000, 3, 3, 1000, 3, 4, 5, 3, 5, 1000,
//    1000, 3, 3, 1000, 3, 4, 5, 3, 5, 1000,
//    1000, 3, 3, 1000, 3, 4, 5, 3, 5, 1000,
//], maskCount: 20)
print("Start \(Date())")

printRMQ(arr: [1, 3, 2], maskCount: 3)
print("End \(Date())")

