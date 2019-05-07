//
//  GameScene.swift
//  trygame
//
//  Created by Jordan Shand on 5/6/19.
//  Copyright © 2019 Jordan Shand. All rights reserved.
//

import SpriteKit
import GameplayKit

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
        
        // creating sprites for the food in the game
        let burger = SKSpriteNode(imageNamed: "burger")
        let pizza = SKSpriteNode(imageNamed: "pizza")
        
        // making random variables for the y position of the food
        let actualBurgerY = random(min: -size.height + burger.size.height, max: size.height)
        let actualPizzaY = random(min: -size.height + pizza.size.height, max: size.height)
        
        burger.position = CGPoint(x: size.width + burger.size.width/2, y: actualBurgerY)
        pizza.position = CGPoint(x: size.width + pizza.size.width/2, y: actualPizzaY)
        
        addChild(burger)
        addChild(pizza)
        
        //speed that the food comes at
        let actualDuration = random(min: CGFloat(2.5), max: CGFloat(4.0))
        
        let destination = -size.width
        
        let actionMoveBurger = SKAction.move(to: CGPoint(x: destination, y: actualBurgerY), duration: TimeInterval(actualDuration))
        
        let actionMovePizza = SKAction.move(to: CGPoint(x: destination, y: actualPizzaY), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        burger.run(SKAction.sequence([actionMoveBurger, actionMoveDone]))
        pizza.run(SKAction.sequence([actionMovePizza, actionMoveDone]))
    }
    
    // Kirby sprite
    let player = SKSpriteNode(imageNamed: "kirby") //declaration of creation of a new sprite
    
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
            
            print("x: \(player.position.x) y: \(player.position.y)")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    
    override func update(_ currentTime: TimeInterval) {
     
    }
}
