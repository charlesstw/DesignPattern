/*: [Previous](@previous)
 簡單工廠 Simple Factory
 又稱靜態工廠，一般來說同工廠內產生的類別會有共同的父類別
 隨著輸入參數不同，簡單工廠會回傳不同的物件
*/
import Foundation
import XCTest

// 冒險者
protocol Adventurer {
    func getType() -> AdventurerType
}

// 弓箭手
class Archer: Adventurer {
    func getType() -> AdventurerType {
        return .archer
    }
}

// 騎士 Knight
class Knight: Adventurer {
    func getType() -> AdventurerType {
        return .knight
    }
}

enum AdventurerType {
    case archer
    case knight
}

/*
 訓練營 (Simple Factory)
 */
class TrainingCamp {
    class func trainAdventurer(type: AdventurerType) -> Adventurer {
        switch type {
        case .knight:
            return Knight()
        case .archer:
            return Archer()
        }
    }
}

/*
 測試
 */

class SimpleFactoryTest: XCTestCase {
    func testTrainAdventurer() {
        let archer = TrainingCamp.trainAdventurer(type: .archer)
        let knight = TrainingCamp.trainAdventurer(type: .knight)
        XCTAssertEqual(archer.getType(), .archer)
        XCTAssertEqual(knight.getType(), .knight)
    }
}

//: [Next](@next)
