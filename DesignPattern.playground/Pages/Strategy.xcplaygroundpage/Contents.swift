//: [Previous](@previous)

import Foundation
import XCTest

/*
 策略模式 Stragegy
 將這種可以互換的演算法(策略)包裝成一個類別
 
 在策略模式中，會有規範用的策略介面，各種實際上的戰鬥策略則是實體策略(Concrete strategy)
 使用策略的冒險者則是環境類別(context)
 */

/*
 戰鬥策略 (strategy)
 */
protocol FightStrategy {
    func execute()
}

/*
 一般攻擊
 Concreate Stratgy
 */
class NormalAttack: FightStrategy {
    func execute() {
        print("使用一般攻擊")
    }
}

/*
 技能攻擊
 Concreate Stratgy
 */
class UseSkillAttack: FightStrategy {
    func execute() {
        print("使用超痛技能攻擊")
    }
}

/*
 道具攻擊
 Concreate Stratgy
 */
class UseItemAttack: FightStrategy {
    func execute() {
        print("使用道具丟火把攻擊")
    }
}

/*
 冒險者(context)
 */

class Adventurer {
    var fightStrategy: FightStrategy = NormalAttack()
    
    func attack() {
        fightStrategy.execute()
    }
    
    func choiceStrategy(flightStrategy: FightStrategy) {
        self.fightStrategy = flightStrategy
    }
}

/*
 策略模式 - 測試
 */
class FlightTest: XCTestCase {
    func testStrategy() {
        let ad = Adventurer()
        
        print("出現史萊姆")
        ad.attack()
        
        print("出現巨大史萊姆")
        ad.choiceStrategy(flightStrategy: UseSkillAttack())
        ad.attack()
        
        print("出現只怕火的殭屍")
        ad.choiceStrategy(flightStrategy: UseItemAttack())
        ad.attack()
    }
}

let test = FlightTest()
test.testStrategy()

/*
 策略模式與簡單工廠模式有什麼不同
 訓練營提供不同的冒險者讓我們可以去進行不同的任務
 vs
 冒險者選擇不同的攻擊策略來攻擊怪物
 
 * 簡單工廠是用來建立物件的模式，關注物件如何被產生
 * 策略模式是一種行為模式，關注的是行為的封裝
 
  工廠模式中的工廠類別並不會去使用產品，因為工廠只關注如何產生建立物件
  策略模式中的環境類別則是使用外部傳入的策略類別，因此我們必須知道傳入的策略實際內容
 */






