/*:
 [Previous](@previous)
 ### 狀態模式 State
 - 目的：將物件的狀態封裝成類別，讓此物件隨著狀態改變時能有不同行為
 會有一個背景類別 Context，Context 會隨著狀態(State)改變
 所以也需要一個狀態介面(State)跟其他實體狀態類別(ConcreteState)
 */
import UIKit

//: [Next](@next)


/*:
#### Example
狀態介面
鬥士狀態
 */
protocol WarriorState {
    func attack(warrior: Warrior)
}
/*:
隨著HP變化的狀態
一般狀態
*/
class NormalState: WarriorState {
    func attack(warrior: Warrior) {
        if warrior.getHp() > 70 {
            print("一般狀態 HP=\(warrior.getHp())")
        } else {
            warrior.setState(state: FuryState())
            warrior.attack()
        }
    }
}
/*:
 隨著HP變化的狀態
 狂怒狀態 hp < 70
*/
class FuryState: WarriorState {
    func attack(warrior: Warrior) {
        let hp = warrior.getHp()
        if hp > 70 {
            warrior.setState(state: NormalState())
            warrior.attack()
        } else if hp <= 30{
            warrior.setState(state: DesperateState())
            warrior.attack()
        } else {
            print("狂怒狀態 HP=\(warrior.getHp()),攻擊增加30%")
        }
    }
}

/*:
隨著HP變化的狀態
狂怒狀態 hp < 30
 */
class DesperateState: WarriorState {
    func attack(warrior: Warrior) {
        let hp = warrior.getHp()
        if hp == 0 {
            warrior.setState(state: ConcreteState())
            warrior.attack()
        } else if hp > 30{
            warrior.setState(state: FuryState())
            warrior.attack()
        } else {
            print("背水一戰狀態 HP=\(warrior.getHp()),攻擊增加50%")
        }
    }
}
/*:
無法戰鬥 hp = 0
*/
class ConcreteState: WarriorState {
    func attack(warrior: Warrior) {
            print("無法戰鬥")
    }
}

/*:
Context 類別
鬥士
*/
class Warrior {
    private var hp: Int = 100
    private var state: WarriorState = NormalState()
    
    func getHp() -> Int {
        return hp
    }
    
    func setState(state: WarriorState) {
        self.state = state
    }
    
    func heal(hp: Int) {
        if hp == 0 {
           self.hp = 0
        } else {
            self.hp = self.hp + hp
        }
        
        if hp > 100 {
            self.hp = 100
        }
    }
    
    func getDagage(hp: Int) {
        self.hp -= hp
        if self.hp < 0 {
            self.hp = 0
        }
    }
    
    func attack() {
        state.attack(warrior: self)
    }
}

func test() {
    let warrior = Warrior()
    warrior.attack()
    
    warrior.getDagage(hp: 30)
    warrior.attack()
    
    warrior.getDagage(hp: 50)
    warrior.attack()
    
    warrior.getDagage(hp: 50)
    warrior.attack()
}

test()










