import UIKit

final class GraphNode<T> {
    let value: T
    let nodes: [GraphNode<T>]
    
    init(value: T, nodes: [GraphNode<T>] = []) {
        self.nodes = nodes
        self.value = value
    }
}


public class Node<T> {
    public var value: T
    public var next: Node<T>?
    
    public init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
    
    func reverse() -> Node<T> {
        guard let nextNode = next else {
            return self
        }
        var currentNode: Node<T>? = self
        var previousNode: Node<T>? = nil
        while let node = currentNode {
            let newNode = node.next
            currentNode?.next = previousNode
            previousNode = currentNode
            currentNode = newNode
        }
        
        return previousNode!
    }
    
    func printForward() {
        var currentNode: Node<T>? = self
        
        var line = ""
        while let node = currentNode {
            line += "\(node.value) \(node.next == nil ? "" : " -> ")"
            
            currentNode = node.next
        }
        
        print(line)
    }
    
    func addNeighbour(_ node: Node<T>) {
        next = node
    }
}

struct Queue<T> {
    var storage: [T] = []
    
    var isEmpty: Bool {
        storage.isEmpty
    }
    
    func peek() -> T? {
        storage.first
    }
    
    mutating func pop() -> T? {
        storage.removeFirst()
    }
    
    mutating func push(_ element: T) {
        storage.append(element)
    }
}


func findMinDistange(matrix: [[Int]], start: Int, end: Int) -> Int {
    struct SearchNode {
        let value: Int
        let distance: Int
    }
    
    guard !matrix.isEmpty, start != end else {
        return 0
    }
    
    let startIndex = start-1
    let endIndex = end-1
    
    guard matrix[startIndex][endIndex] == 0 else {
        return 1
    }
    
    var queue = Queue<SearchNode>()
    var visited: Set<Int> = []
    
    var index = 0
    matrix[startIndex].forEach { (value) in
        if value != 0 {
            queue.push(SearchNode(value: index, distance: 1))
        }
        index += 1
    }
    
    while !queue.isEmpty {
        let node = queue.pop()!
        guard  node.value != endIndex  else {
            return node.distance
        }
        
        for (index, nextNode) in matrix[node.value].enumerated() where !visited.contains(index) && nextNode != 0 {
            visited.insert(index)
            queue.push(SearchNode(value: index, distance: node.distance + 1))
        }
    }
    
    return 0
}


let matrixA: [[Int]] = [
    [0, 1, 0, 0, 1],
    [1, 0, 1, 0, 0],
    [0, 1, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0]
]



let matrixB: [[Int]] = [
    [0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
    [1, 0, 0, 1, 1, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0, 0, 1, 0],
    [0, 1, 0, 0, 0, 0, 1, 0, 0, 0],
    [0, 1, 1, 0, 0, 0, 0, 0, 0, 1],
    [0, 0, 0, 0, 0, 0, 1, 0, 0, 1],
    [0, 1, 0, 1, 0, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
    [0, 0, 1, 0, 0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 1, 1, 0, 0, 0, 0]
]





let nodeA = Node(value: "A")
let nodeB = Node(value: "B")
let nodeC = Node(value: "C")
let nodeD = Node(value: "D")
let nodeE = Node(value: "E")

nodeA.addNeighbour(nodeB)
nodeB.addNeighbour(nodeC)
nodeC.addNeighbour(nodeD)

nodeA.printForward()

nodeA.reverse().printForward()





