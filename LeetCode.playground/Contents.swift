import UIKit

class Solution {
    func myAtoi(_ s: String) -> Int {
            var filteredChars: [Character] = []
            var lastChar: Character = " "
            func isValid(_ char: Character, position: Int, lastChar: Character) -> Bool {
                switch char {
                case "0"..."9":
                        return true
                case "+", "-":
                        return position == 0 && lastChar != "0"
                    default:
                        return false
                }
            }
        
        var firstValidInput: Bool = false
            

            for char in Array(s) {
                if !firstValidInput {
                    firstValidInput = isValid(char, position: filteredChars.count, lastChar: lastChar)
                }
               // print(firstValidInput)
                //print("cur - \(char) - \(isValid(char, position: filteredChars.count , lastChar: lastChar))")
                /// First array lettter, if space and 0 ignore it
                if filteredChars.isEmpty,  char == " " || char == "0", !firstValidInput {
                    lastChar = char
                    continue
                } else if char == " " {
                    lastChar = char
                    break
                } else if char == "0", (Int(String(filteredChars)) ?? 0 == 0){
                    lastChar = char
                    continue
                /// If valid character add to array.\
                /// Check if it have still valid amount of digits.
                } else if isValid(char, position: filteredChars.count, lastChar: lastChar), filteredChars.count < 11 {
                    //print("position: \(filteredChars.count), isValid: \(isValid(char, position: filteredChars.count, lastChar: lastChar))")
                    filteredChars.append(char)
                    
                /// Found first unvalid char. try to constract Int
                } else {
                    break
                }

                lastChar = char
            }
            
           print(String(filteredChars))
            return max(min(Int(String(filteredChars)) ?? 0, 2_147_483_647), -2_147_483_648)
        }
}

//Solution().myAtoi("21474836460")
//Solution().myAtoi("010")
//Solution().myAtoi("     +004500")
//Solution().myAtoi("0  123")
//Solution().myAtoi("-13+8")


func a3() {
    print("a3")
}

func a2() {
    let a = 3
    a3()
}

func a1() {
    let b = 5
    a2()
}

a1()
