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
        sceneView.autoenablesDefaultLighting = true

        
    }
    
    @objc func endDraw(){
        DispatchQueue.main.async {
            self.touched = false
        }
        
    }
    
    @objc func startDraw(){
        DispatchQueue.main.async {
            self.touched = true
        }
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
    
    func get_relative_position(_ current_frame: ARFrame, _ node:SCNNode, _ node_to_add: SCNNode){
        let camera = current_frame.camera
        let transform = camera.transform
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.1
        node.simdTransform = matrix_multiply(transform, translation)
        node_to_add.addChildNode(node)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if touched == true{
            let ball = SCNSphere(radius: 0.005)
            let node = SCNNode()
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.red
            ball.materials = [material]
            node.geometry = ball
            if let frame = sceneView.session.currentFrame{
                let node_to_add = sceneView.scene.rootNode
                get_relative_position(frame, node, node_to_add)
            }

            
        }
    }

}
