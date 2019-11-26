//
//  CharRPG.swift
//  KataRPG
//
//  Created by Federico Jordan on 26/11/2019.
//  Copyright © 2019 PedidosYa. All rights reserved.
//

import Foundation

class CharRPG {
    struct Constants {
        static let maxHealth: Float = 1000
        static let minHealth: Float = 0
        static let diffLvl: Int = 5
    }

    var health: Float = Constants.maxHealth
    var level: Int = 1
    var isAlive: Bool {
        return health > 0
    }

    private let id: UUID = .init()

    init(health: Float = 1000, level: Int = 1) {
        self.health = health
        self.level = level
        normalizeHealth()
    }

    private func normalizeHealth() {
        if health > Constants.maxHealth {
            health = Constants.maxHealth
        } else if health <= Constants.minHealth {
            health = Constants.minHealth
        }
    }

    func attack(character: CharRPG, damage: Float) {
        if self != character {
            let finalDamage = calculateFinalDmg(character: character, damage: damage)
            character.receive(damage: finalDamage)
        }
    }

    private func calculateFinalDmg(character: CharRPG, damage: Float) -> Float {
        var newDmg = damage
        if character.level - self.level >= Constants.diffLvl {
            newDmg /= 2
        } else if self.level - character.level >= Constants.diffLvl {
            newDmg *= 1.5
        }
        return newDmg
    }


    private func receive(damage: Float) {
        health -= damage
        normalizeHealth()
    }

    func heal(character: CharRPG, power: Float) {
        if character == self {
            character.receive(power: power)
        }
    }

    private func receive(power: Float) {
        if !isAlive {
            return
        }

        health += power
        normalizeHealth()
    }
}

extension CharRPG: Equatable {
    static func == (lhs: CharRPG, rhs: CharRPG) -> Bool {
        return lhs.id == rhs.id
    }

}

protocol Attacker {

}

protocol Healer {

}
