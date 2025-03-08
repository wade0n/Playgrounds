import UIKit

protocol Human {
    var name: String { get }
}

struct Teacher: Human {
    let name: String
    let subject: String
    let yearsOfExperience: Int
}

struct Student: Human {
    let name: String
    let grade: Int
    let favoriteSubject: String
}

let teacher1 = Teacher(name: "Mr. Smith", subject: "Math", yearsOfExperience: 10)
let teacher2 = Teacher(name: "Ms. Johnson", subject: "Science", yearsOfExperience: 5)

let student1 = Student(name: "Alice", grade: 10, favoriteSubject: "Math")
let student2 = Student(name: "Bob", grade: 9, favoriteSubject: "English")

let array: [Human] = [teacher1, teacher2, student1, student2]
