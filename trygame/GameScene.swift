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
    
    let player = SKSpriteNode(imageNamed: "player") //declaration of creation of a new sprite
    
    override func didMove(to view: SKView) {

        backgroundColor = SKColor.white //changing the backforund color of the scheme
        
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.1) // setting the postion of the sprite
        
        addChild(player)  //to make the sprite appear
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
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    
    override func update(_ currentTime: TimeInterval) {
     
    }
}
