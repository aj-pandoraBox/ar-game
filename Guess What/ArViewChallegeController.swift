//
//  ArViewChallegeController.swift
//  Guess What
//
//  Created by AnexY on 10/03/18.
//  Copyright © 2018 AnexY. All rights reserved.
//

import UIKit
import ARKit
class ArViewChallegeController: UIViewController,ARSCNViewDelegate,UIGestureRecognizerDelegate {
    @IBOutlet weak var sceneview: ARSCNView!
    @IBOutlet weak var scoreboard: UIView!
    
    @IBOutlet weak var animalviewguess: UIView!
    @IBOutlet weak var passcountlbl: UILabel!
    @IBOutlet weak var woncountlbl: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var addBtn: UIButton!
   
    @IBOutlet weak var blackview: UIView!
    var whichguess = String()
    let config = ARWorldTrackingConfiguration()
    var correctcount = 0
    var passcount = 0
    
    var colorAr = UIColor.red
    var seconds = 5
    var timer1:Timer!
    var isTimerRunning = true
    
    @IBOutlet weak var correct: UIButton!
    
    @IBOutlet weak var pass: UIButton!
    
    
    @IBAction func startanimalguessbtnclk(_ sender: UIButton) {
        animalviewguess.isHidden = true
        self.blackview.isHidden = true
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        if self.whichguess == "animal"
        {
            animalviewguess.isHidden = false
            self.blackview.isHidden = false
            print("animals clk")
            stopgame()

        }
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(ArViewChallegeController.doubleTapped))
        tapGR.delegate = self
        tapGR.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGR)
        
        timer1 = Timer()
        
        self.sceneview.delegate = self
self.sceneview.session.run(config)
        addBtn.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        addBtn.layer.cornerRadius = 0.5 * addBtn.bounds.size.width
        addBtn.clipsToBounds = true
        
        runTimer()
        runTest()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ArViewChallegeController.handleSwipe(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        
    }
    @objc func handleSwipe(gesture: UIGestureRecognizer)
    {
        dismiss(animated: true, completion: nil)
        print("rightswipped")
    }
    func runTimer()
    {
        timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ArViewChallegeController.updateTimer)), userInfo: nil, repeats: true)
        
        
    }
    
    func stopgame()
    {
        timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ArViewChallegeController.stopgametimer)), userInfo: nil, repeats: true)
        
        
    }
    
    
    func runTest()
    {
        timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ArViewChallegeController.timerover)), userInfo: nil, repeats: true)
        
        
    }
    @objc func stopgametimer()
    {
        if timer.text == "0"
        {
            print("stopgame")
        }
    }
    
    @objc func timerover()
    {
        if self.timer.text == "0"
        {
            timer1.invalidate()
            self.scoreboard.isHidden = false
            
        }else
        {
            self.scoreboard.isHidden = true
            
        }
    }
    
    
    @objc func updateTimer()
    {
        seconds -= 1
        timer.text = "\(seconds)"
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let poinofview = self.sceneview.pointOfView else {return}
        let transform = poinofview.transform
        let oreintation = SCNVector3(-transform.m31,-transform.m32,-transform.m33)
        let position = SCNVector3(transform.m41,transform.m42,transform.m43)
        let pointofcam = oreintation + position
        
        DispatchQueue.main.async {
            if self.addBtn.isHighlighted
            {
                let spherenode = SCNNode(geometry: SCNSphere(radius: 0.02))
                spherenode.geometry?.firstMaterial?.diffuse.contents = self.colorAr
                spherenode.position = pointofcam
                self.sceneview.scene.rootNode.addChildNode(spherenode)
                
                
            }else{
                let spherenodes = SCNNode(geometry: SCNSphere(radius: 0.01))
                spherenodes.name = "yup"
                spherenodes.geometry?.firstMaterial?.diffuse.contents = self.colorAr
                self.sceneview.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if node.name == "yup"
                    {
                        node.removeFromParentNode()
                    }
                })
                spherenodes.position = pointofcam
                self.sceneview.scene.rootNode.addChildNode(spherenodes)
                
            }
        }
        
    }
   

   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func passbtn(_ sender: UIButton) {
        passcount += 1
        self.passcountlbl.text = "\(passcount)"
        print(passcount)
    }
    @IBAction func restartbtbclk(_ sender: UIButton) {
        self.scoreboard.isHidden = true
        self.timer.text = "0"
        self.seconds = 50
        self.correctcount = 0
        self.passcount = 0
        self.sceneview.scene.rootNode.enumerateChildNodes({ (node, _) in
            
                node.removeFromParentNode()
            
        })
        runTest()

    }
    
    @IBAction func correctbtn(_ sender: UIButton) {
        correctcount += 1
        self.woncountlbl.text = "\(correctcount)"
        print(correctcount)

    }
    
    @objc func doubleTapped()
    {
     print("double tapped")
        var array_Color_Ar = [UIColor.red,UIColor.blue,UIColor.green]

        let randomIndex = Int(arc4random_uniform(UInt32(array_Color_Ar.count)))
        print(array_Color_Ar[randomIndex])
self.colorAr = array_Color_Ar[randomIndex]
        
    }
    
}

func +(left:SCNVector3,right:SCNVector3) -> SCNVector3
{
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}
