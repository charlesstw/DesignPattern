//: [Previous](@previous)

import Foundation
import XCTest

/*
 Decorator 裝飾者模式
 動態的將功能附加在物件上
 裝飾者與被裝飾者都實做同一個 interface 裝飾者包被裝飾者
 */


/// 冒險者介面(component)-規範冒險者該有能力
protocol Adventurer {
    func attack()
}

/// 長槍兵(Concrete component)
class Lancer: Adventurer {
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func attack() {
        print("長槍攻擊 by " + name)
    }
}


/// 稱號介面 Decorator
class Title: Adventurer {
    private var adventurer: Adventurer
    
    init(adventruer: Adventurer) {
        self.adventurer = adventruer
    }
    
    func attack() {
        adventurer.attack()
    }
}

/// 稱號-強壯
class TitleStrong: Title {
    override init(adventruer: Adventurer) {
        super.init(adventruer: adventruer)
    }
    
    override func attack() {
        print("猛力")
        super.attack()
    }
}

/// 稱號-敏捷
class TitleAgile: Title {
    override init(adventruer: Adventurer) {
        super.init(adventruer: adventruer)
    }
    
    override func attack() {
        print("快速")
        super.attack()
    }
}

let jobs = Lancer(name: "Jobs")
jobs.attack()
print("-----")
let strongJobs = TitleStrong(adventruer: jobs)
strongJobs.attack()
print("-----")
let agileStringJobs = TitleAgile(adventruer: strongJobs)
agileStringJobs.attack()
