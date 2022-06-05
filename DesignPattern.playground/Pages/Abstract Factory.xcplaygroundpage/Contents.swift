//: [Previous](@previous)

import Foundation
import XCTest

/*
 抽象工廠模式 Abstract Factory
 用一個工廠介面來產生一系列相關的物件，但實際建立哪些物件由實作的子類別來實現
 
 若一個產品有多個配件，運用工廠模式則需要多個工廠來完成一個產品，工廠介面現在的規範不是工廠
 現在生產的不只是一種產品，而是生產一個產品類別的一系列所有配件
 */

//: [Next](@next)

/*
 上衣界面 Product
 */
protocol Clothes {
    var defence: Int { get }
}

extension Clothes {
    func display() {
        print("type:\(self),def:\(defence)")
    }
}

/*
 盔甲 Concrete Product - 騎士上衣
 */
struct Armor: Clothes {
    var defence: Int = 30
}

/*
 皮甲 Concrete Product - 弓箭手上衣
 */

struct Leather: Clothes {
    var defence: Int = 20
}
/* =================================== */

/*
 武器界面 Product
 */

protocol Weapon {
    var atk: Int { get }
    var range: Int { get }
}

extension Weapon {
    func display() {
        print("type:\(self), atk:\(atk), range:\(range)")
    }
}

/*
 長劍 Concrete Product 長劍武器
 */
struct LongSword: Weapon {
    var atk: Int
    var range: Int
}

/*
 弓 Concrete Product 弓箭武器
 */
struct Bow: Weapon {
    var atk: Int
    var range: Int
}

/*
 裝備工廠介面 (Factory) 定義每一間工廠依該藥生產的東西
 */
protocol EquipFactory {
    func productWeapon() -> Weapon
    func productArmor() -> Clothes
}


/*
 專門產生騎士裝備的工廠 ConcreteFactory
 */
struct KnightEquipFactory: EquipFactory {
    func productWeapon() -> Weapon {
        return LongSword(atk: 10, range: 3)
    }
    
    func productArmor() -> Clothes {
        return Armor(defence: 10)
    }
}

/*
 專門產生弓箭手裝備的工廠
 */

struct ArcherEquipFactory: EquipFactory {
    func productWeapon() -> Weapon {
        return Bow(atk: 5, range: 10)
    }
    
    func productArmor() -> Clothes {
        return Leather(defence: 8)
    }
}

/*
 工廠模式與抽象工廠模式比較
 工廠模式：工廠模式注重的是如何產生一個物件品
 抽象工廠模式：抽象工廠模式注重在產品的抽象關係，像武器與衣服本來是扯不上關係的兩種物品，
 但兩種物品皆屬於同一個冒險者的裝備，因此他們就有了這層抽象關係
 */

/*
 冒險者介面
 */
protocol Adventurer {
    var weapon: Weapon {set get}
    var closthes: Clothes {set get}
}

extension Adventurer {
    func display() {
        print("Adventurer type:\(self)")
    }
}

/*
 騎士
 */
struct Knight: Adventurer {
    var weapon: Weapon
    var closthes: Clothes
    
    func display() {
        print("我是騎士，裝備：")
        weapon.display()
        closthes.display()
    }
}

/*
 弓箭手
 */
struct Archer: Adventurer {
    var weapon: Weapon
    var closthes: Clothes
    
    func display() {
        print("我是弓箭手，裝備：")
        weapon.display()
        closthes.display()
    }
}

/*
 工廠介面 - 冒險者訓練營
 只是一個概念或規範，要訓練什麼，要怎麼訓練交給實作 protocol 的實作
 */
protocol TrainingCamp {
    /*
     訓練後請給我一個冒險者
     */
    func trainAdventurer() -> Adventurer
}

/*
 實體工廠 - 弓箭手訓練營
 */
struct ArcherTraingCamp: TrainingCamp {
    let equipFactory = ArcherEquipFactory()
    
    func trainAdventurer() -> Adventurer {
        print("訓練一個弓箭手")
        let archer = Archer(weapon: equipFactory.productWeapon(), closthes: equipFactory.productArmor())
        return archer
    }
}

/*
 實體工廠 - 騎士訓練營
 */
struct KnightTraingCamp: TrainingCamp {
    let equipFactory = KnightEquipFactory()
    
    func trainAdventurer() -> Adventurer {
        print("訓練一個騎士")
        let knight = Knight(weapon: equipFactory.productWeapon(), closthes: equipFactory.productArmor())
        return knight
    }
}

/*
 抽象工廠模式測試
 */
class AbstractFactoryTest: XCTestCase {
    func testEquipFactory() {
        print("測試抽象工廠模式")
        let knightCamp = KnightTraingCamp()
        let knight = knightCamp.trainAdventurer()
        knight.display()
        XCTAssertEqual(knight.weapon.atk, 10)
        XCTAssertEqual(knight.closthes.defence, 10)
        
        let archerCamp = ArcherTraingCamp()
        let archer = archerCamp.trainAdventurer()
        archer.display()
        
        XCTAssertEqual(archer.weapon.atk, 5)
        XCTAssertEqual(archer.closthes.defence, 8)
        
    }
}

let test = AbstractFactoryTest()
test.testEquipFactory()
