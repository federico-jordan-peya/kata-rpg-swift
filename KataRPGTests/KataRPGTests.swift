//
//  KataRPGTests.swift
//  KataRPGTests
//
//  Created by Federico Jordan on 26/11/2019.
//  Copyright © 2019 PedidosYa. All rights reserved.
//

import XCTest
@testable import KataRPG

class KataRPGTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHealth() {
        let characterRPG = CharRPG()

        XCTAssert(characterRPG.health == 1000)
    }

    func testIsAlive() {
        let characterRPG = CharRPG()
        XCTAssertTrue(characterRPG.isAlive)
    }

    func testLevel() {
        let characterRPG = CharRPG()
        XCTAssertTrue(characterRPG.level == 1)
    }

    func testAttackOtherCharacter() {
        // Given
        let character1 = CharRPG()
        let character2 = CharRPG()

        // When
        character1.attack(character: character2, damage: 500)

        // Verify
        XCTAssert(character2.health == 500)

    }

    func testCharacterDeath() {
        // Given
        let character1 = CharRPG()
        let character2 = CharRPG()

        // When
        character1.attack(character: character2, damage: 1500)

        // Verify
        XCTAssert(character2.health == 0)
        XCTAssertFalse(character2.isAlive)
    }

    func testHealCharacter() {
        // Given
        let character = CharRPG(health: 500)

        // When
        character.heal(character: character, power: 200)

        // Verify
        XCTAssert(character.health == 700)
    }

    func testHealCharacterMoreThan1000() {
        // Given
        let character1 = CharRPG()
        let character2 = CharRPG()

        // When
        character1.heal(character: character2, power: 200)

        // Verify
        XCTAssert(character2.health == 1000)
    }

    func testCannotHealDeadCharacter() {
        // Given
        let character1 = CharRPG()
        let character2 = CharRPG()
        character1.attack(character: character2, damage: 1500)

        // When
        character1.heal(character: character2, power: 200)

        // Verify
        XCTAssert(character2.health == 0)
        XCTAssertFalse(character2.isAlive)
    }

    func testCharacterCannotDealDamageItself() {
        // Given
        let character = CharRPG()

        // When
        character.attack(character: character, damage: 500)

        // Verify
        XCTAssert(character.health == 1000)
    }

    func testCharacterCanOnlyHealItself() {
        // Given
        let character1 = CharRPG()
        let character2 = CharRPG(health: 500)

        // When
        character1.heal(character: character2, power: 200)

        // Verify
        XCTAssert(character2.health == 500)
    }

    func testHighLevelCharReducedDmgAnother() {
        // Given
        let character1 = CharRPG(level: 1)
        let character2 = CharRPG(health: 500, level: 6)

        // When
        character1.attack(character: character2, damage: 200)

        // Verify
        XCTAssert(character2.health == 400)
    }

    func testLowLevelCharIncreaseDmgAnother() {
        // Given
        let character1 = CharRPG(level: 6)
        let character2 = CharRPG(level: 1)

        // When
        character1.attack(character: character2, damage: 200)

        // Verify
        XCTAssert(character2.health == 700)
    }

}
