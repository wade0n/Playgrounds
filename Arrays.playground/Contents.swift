import UIKit

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let array = (nums1 + nums2).sorted()
        let lenght = array.count
        if lenght % 2 == 0 {
            return Double(array[lenght/2] + array[lenght/2 - 1]) / 2
        } else {
            return Double(array[lenght / 2])
        }
    }
    
    func findNewMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let maxLength = nums1.count + nums2.count
        let isEven = maxLength % 2 == 0
        var curValue: Int = 0
        var previousValue: Int = 0
        var leftIndex = 0, rightIndex = 0
        
        for i in 0...maxLength/2 {
            previousValue = curValue
            guard  leftIndex < nums1.count else {
                curValue = nums2[rightIndex]
                rightIndex += 1
                continue
            }
            
            guard  rightIndex < nums2.count else {
                curValue = nums1[leftIndex]
                leftIndex += 1
                continue
            }
            
            let leftValue = nums1[leftIndex]
            let rightValue = nums2[rightIndex]
            
            if leftValue < rightValue {
                curValue = nums1[leftIndex]
                leftIndex += 1
            } else {
                curValue = nums2[rightIndex]
                rightIndex += 1
            }
        }
        
        if isEven {
            return Double(curValue + previousValue) / 2
        } else {
            return Double(curValue)
        }
    }
}

//print(Solution().findNewMedianSortedArrays([1,2], [3]))
//print(Solution().findNewMedianSortedArrays([1,2], [3,4]))

//MARK: - Dzen tasks
let beginArray: [Int?] = [1,2,3, nil, 4, 5, 6]
let array = beginArray.compactMap { $0.map { "\($0)"}}[0...5]
print(type(of: array))
