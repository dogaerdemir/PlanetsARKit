import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate
{

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        /*
         
        // DEFAULTUN ÜZERİNE YAPTIĞIMIZ İŞLEMLER
         
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let shipScene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = shipScene
        
        for node in sceneView.scene.rootNode.childNodes
        {
            let moveShip = SCNAction.moveBy(x: 0.0, y: 0.5, z: -2, duration: 4)
            let repeatForever = SCNAction.repeatForever(moveShip)
            node.runAction(repeatForever)
        }
         
         */
        
        // let myBox = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        
        let venus = createSphere(radius: 0.11, content: "venus.png", vector: SCNVector3(0, 0.2, -1))
        let world = createSphere(radius: 0.1, content: "world.png", vector: SCNVector3(0.25, 0.2, -1))
        let mars = createSphere(radius: 0.10, content: "mars.png", vector: SCNVector3(0.5, 0.2, -1))
        
        sceneView.scene.rootNode.addChildNode(world)
        sceneView.scene.rootNode.addChildNode(mars)
        sceneView.scene.rootNode.addChildNode(venus)
        
        sceneView.automaticallyUpdatesLighting = true
    }
    
    func createSphere(radius: CGFloat, content:String, vector: SCNVector3) -> SCNNode
    {
        let mySphere = SCNSphere(radius: radius)
        let boxMaterial = SCNMaterial()
        
        boxMaterial.diffuse.contents = UIImage(named: "art.scnassets/\(content)")
        mySphere.materials = [boxMaterial]
        
        let node = SCNNode()
        node.position = vector
        node.geometry = mySphere
        
        let turn = SCNAction.rotate(by: 0.5, around: SCNVector3(x: 0, y: 0.4, z: 0), duration: 2)
        let repeatedTurn = SCNAction.repeatForever(turn)
        node.runAction(repeatedTurn)
        
        return node
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
