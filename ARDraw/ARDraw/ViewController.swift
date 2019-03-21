//
//  ViewController.swift
//  ArDraw
//
//  Created by Swapnik R. Katkoori on 3/21/19.
//  Copyright © 2019 Swapnik R. Katkoori. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var x:Float = 0
    var touched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        let drawButton = UIButton()
        drawButton.frame = CGRect(x: 100, y: 700, width: 200, height: 100)
        drawButton.setTitle("Draw", for: .normal)
        drawButton.backgroundColor = UIColor.blue
        drawButton.addTarget(self, action: #selector(endDraw), for: .touchUpInside)
        drawButton.addTarget(self, action: #selector(startDraw), for: .touchDown)
        view.addSubview(drawButton)
        
    }
    
    @objc func endDraw(){
        touched = false
    }
    
    @objc func startDraw(){
        touched = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if touched == true{
            let ball = SCNSphere(radius: 0.01)
            let node = SCNNode()
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.red
            ball.materials = [material]
            node.geometry = ball
            node.position = SCNVector3Make(x, 0, -0.5)
            sceneView.autoenablesDefaultLighting = true
            sceneView.scene.rootNode.addChildNode(node)
            x += 0.01
        }
    }

}
