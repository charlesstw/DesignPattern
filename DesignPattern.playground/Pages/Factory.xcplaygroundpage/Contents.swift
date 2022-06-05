//: [Previous](@previous)

import Foundation
import XCTest

/*
 工廠模式 Factory
 提供一個工廠介面，將產生實體的程式碼交由子類別個別實現
 
 與簡單工廠概念差異：
 簡單工廠直接管理生產所有產品，利用 if else, switch 判斷產生不同產品，工廠模式則是將工廠提升為一個概念
 實際上生產產品的是實作 protocol 的實體工廠，幾種產品就會有幾個工廠。
 */

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

protocol TrainingCamp {
    func trainAdventurer() -> Adventurer
}

/*
 弓箭手訓練營 (ConcreteFacotry)
 */
class ArcherTrainingCamp: TrainingCamp {
    func trainAdventurer() -> Adventurer {
        return Archer()
    }
}

/*
 騎士訓練營 (ConcreteFacotry)
 */
class KnightTrainingCamp: TrainingCamp {
    func trainAdventurer() -> Adventurer {
        return Knight()
    }
}


/*
 測試
 */
class FactoryTest: XCTestCase {
    func testTrainingAdventurer() {
        let archer = ArcherTrainingCamp().trainAdventurer()
        let knight = KnightTrainingCamp().trainAdventurer()
        
        XCTAssertEqual(archer.getType(), .archer)
        XCTAssertEqual(knight.getType(), .knight)
    }
}
