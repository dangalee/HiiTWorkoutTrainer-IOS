//
//  StickmanScene.swift
//  HIITWorkoutTrainer
//
//  Created by MacBook on 4/17/22.
//Submission Date : 04/24/22 11:59 pm
//Team : a02section300team04
//Members:
//  Jordan Keyser jekeyser@iu.edu
//  Jungmin Lee jle18@iu.edu
//  Suriya Narayanasamy surnara@iu.edu


import SpriteKit
class StickmanScene: SKScene {
    /*
     An SKSpriteNode is an onscreen graphical element that can be initialized from an image or a solid color.
     An SKTexture object is an image that can be applied to SKSpriteNode()
     An SKTextureAtlas is a collection of textures that were created from an .atlas folder
     © Apple Developer Documentation
     */
    private var stickman = SKSpriteNode()
    private var stickmanMoving: [SKTexture] = [] //array that takes SKTexture
    
    /*
     function didMove(to:) tells you when the scene is presented by a view © Apple Developer Documentation
     Therefore, whenever SKView.presentScene(scene) happens, the body of this function will be executed
     */
    override func didMove(to view: SKView) {
        backgroundColor = .systemGray4
        buildWorkOutMan()
        animateStickman()
    }
    //Bring Workout Mana images from atlas folder and store it in SKTexture Array "StickmanMoving"
    func buildWorkOutMan() {
        let manPNGs = SKTextureAtlas(named: "WorkOutImages")//Folder : WorkOutImages.atlas
        var allImgs: [SKTexture] = []
        
        //Use for-loop to append all Images to array takt takes SKTexture.
        let numImages = manPNGs.textureNames.count - 1
        for i in 0...numImages {
            allImgs.append(manPNGs.textureNamed("Img\(i)"))
            
        }
        //Assign allImgs to stickmanMoving (Both of them are array that takes SKTexture)
        stickmanMoving = allImgs
        
        //get the very first image (index 0) and assign it into SKSpriteNode, and put it in the middle of the frame.
        stickman = SKSpriteNode(texture: stickmanMoving[0])
        stickman.position = CGPoint(x: frame.midX, y: frame.midY)
        //add stickman(SKSpriteNode) to the end of the receiver(SKView)'s list of child nodes
        addChild(stickman)
    }
    //Animate Stickman forever
    func animateStickman() {
        //repeat forever converting all of imgs.
        stickman.run(SKAction.repeatForever(SKAction.animate(with: stickmanMoving, timePerFrame: 0.1, resize: false, restore: true)))
    }
}
