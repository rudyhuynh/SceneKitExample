//
//  GameViewController.swift
//  SceneKitExample
//
//  Created by Admin on 14/06/2023.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        scene.rootNode.addChildNode(cameraNode)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
        
        let html = """
        <html>
        <body>
        <p style="color: blue;font-size: 50px">This is blue!</p>
        </body>
        </html>
        """
        
        let data = Data(html.utf8)
        let content = "This is an example of a very super extra long text."
        let scnText = SCNText(string: "", extrusionDepth: 0.2)
        let paragraphStyle1 = NSMutableParagraphStyle()
        paragraphStyle1.alignment = .center
        paragraphStyle1.lineHeightMultiple = 5
        paragraphStyle1.lineBreakMode = .byWordWrapping
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.black,
            .font: UIFont(name: "Helvetica", size: 0.5) as Any,
            .paragraphStyle: paragraphStyle1
        ]
        
//        scnText.string = try! NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        
        scnText.string = NSAttributedString(string: content, attributes: attributes)
        
        //        scnText.font = UIFont (name: "Helvetica", size: 0.4)
        scnText.alignmentMode = CATextLayerAlignmentMode.center.rawValue
//        scnText.isWrapped = true
        let size = CGSize(width: 4, height: 6)
        scnText.containerFrame = CGRect(origin: scnText.containerFrame.origin, size: size)
        let scnTextNode = SCNNode(geometry: scnText)
        
        ship.addChildNode(scnTextNode)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        let paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.alignment = .left
        paragraphStyle2.lineHeightMultiple = 5
        paragraphStyle2.lineBreakMode = .byWordWrapping
        let attributesUILabel: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.black,
            .font: UIFont(name: "Helvetica", size: 12) as Any,
            .paragraphStyle: paragraphStyle2
        ]
        label.numberOfLines = 0
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.layer.borderWidth = 3.0
        label.attributedText = NSAttributedString(string: content, attributes: attributesUILabel)
        self.view.addSubview(label)
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
}
