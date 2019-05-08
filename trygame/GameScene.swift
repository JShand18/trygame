//
//  GameScene.swift
//  trygame
//
//  Created by Jordan Shand on 5/6/19.
//  Copyright © 2019 Jordan Shand. All rights reserved.
//
import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let none : UInt32 = 0
    static let all : UInt32 = UInt32.max
    static let player : UInt32 = 0b1 // player is represented by first bit
    static let pizza: UInt32 = 0b10 // pizza by third bit
}

class GameScene: SKScene {
    
    //creation of functions to make random variables
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min:CGFloat, max:CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    // Burger sprite
    func addFood() {
        
        
        let pizza = SKSpriteNode(imageNamed: "pizza")
        pizza.physicsBody = SKPhysicsBody(rectangleOf: pizza.size) // ^
        pizza.physicsBody?.isDynamic = true// ^^
        pizza.physicsBody?.categoryBitMask = PhysicsCategory.pizza // ^^^
        pizza.physicsBody?.contactTestBitMask = PhysicsCategory.player // ^^^^
        pizza.physicsBody?.collisionBitMask = PhysicsCategory.none // ^^^^^
        
        
        // making random variables for the y position of the food
        let actualPizzaY = random(min: -size.height + pizza.size.height, max: size.height - pizza.size.height * 4)
        
        pizza.position = CGPoint(x: size.width + pizza.size.width/2, y: actualPizzaY)
        
        //addChild(burger)
        addChild(pizza)
        
        //speed that the food comes at
        let actualDuration = random(min: CGFloat(2.5), max: CGFloat(4.0))
        
        let destination = -size.width
        
        
        let actionMovePizza = SKAction.move(to: CGPoint(x: destination, y: actualPizzaY), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        pizza.run(SKAction.sequence([actionMovePizza, actionMoveDone]))
    }
    
    // Kirby sprite
    let player = SKSpriteNode(imageNamed: "kirby") //declaration of creation of a new sprite
    
    var counter = 0
    
    
    override func didMove(to view: SKView) {
        
        
        backgroundColor = SKColor.white //changing the backforund color of the scheme
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5) // setting the postion of the sprite
        player.position = CGPoint(x: 0, y: 0)
        
        
        addChild(player)  //to make the sprite appear
        
        
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addFood),
                SKAction.wait(forDuration: 1.0)
                ])
        ))
        
        physicsWorld.gravity = .zero //set the gravity of the of the game scene to none
        physicsWorld.contactDelegate = self  // allows the delegate to contact when two bodies collide
        
        
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{

            // moving kirby around following the user's finger
            let location = touch.location(in: self)
            player.position.x = location.x
            player.position.y = location.y
            
            player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
            player.physicsBody?.isDynamic = true
            player.physicsBody?.categoryBitMask = PhysicsCategory.player
            player.physicsBody?.contactTestBitMask = PhysicsCategory.pizza
            player.physicsBody?.collisionBitMask = PhysicsCategory.none
            player.physicsBody?.usesPreciseCollisionDetection = true


            print("x: \(player.position.x) y: \(player.position.y)")
       }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func playerDidCollideWithPizza(pizza: SKSpriteNode) {
        print("Eaten!")
        pizza.removeFromParent()
        counter += 1
        print(counter)
    }
}

extension GameScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        print("1")
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            print("2.1")
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            print("2.2")
        }
        
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.pizza != 0)) {
            print("3.1")
            if let player = firstBody.node as? SKSpriteNode,
                let pizza = secondBody.node as? SKSpriteNode {
                playerDidCollideWithPizza(pizza: pizza)
            }
        }
    }
}
