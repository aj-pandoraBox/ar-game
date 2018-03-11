//
//  ViewControllerPlay.swift
//  Guess What
//
//  Created by AnexY on 10/03/18.
//  Copyright © 2018 AnexY. All rights reserved.
//

import UIKit

class ViewControllerPlay: UIViewController {
var myvalue = String()
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view12: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var view21: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //this is for view1
        self.view1.layer.cornerRadius = 30
        self.view1.clipsToBounds = true
        
        self.view1.layer.shadowPath = UIBezierPath(roundedRect: self.view1.bounds, cornerRadius: self.view1.layer.cornerRadius).cgPath

        self.view1.layer.shadowColor = UIColor.black.cgColor
        self.view1.layer.shadowOpacity = 0.5
        self.view1.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.view1.layer.borderColor = UIColor.black.cgColor
        self.view1.layer.borderWidth = 1
        self.view1.layer.shadowRadius = 1
        self.view1.layer.masksToBounds = false
        
        
        
        self.image1.layer.cornerRadius = 30
        
        self.image1.layer.shadowPath = UIBezierPath(roundedRect: self.image1.bounds, cornerRadius: self.image1.layer.cornerRadius).cgPath
        
       
       
        
        
        
        self.view12.layer.cornerRadius = 30
        
        self.view12.layer.shadowPath = UIBezierPath(roundedRect: self.view12.bounds, cornerRadius: self.view12.layer.cornerRadius).cgPath
        
       
        
        //this is for view 2
        
        self.view2.layer.cornerRadius = 30
        self.view2.clipsToBounds = true
        
        self.view2.layer.shadowPath = UIBezierPath(roundedRect: self.view2.bounds, cornerRadius: self.view2.layer.cornerRadius).cgPath
        
        self.view2.layer.shadowColor = UIColor.black.cgColor
        self.view2.layer.shadowOpacity = 0.5
        self.view2.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.view2.layer.borderColor = UIColor.black.cgColor
        self.view2.layer.borderWidth = 1
        self.view2.layer.shadowRadius = 1
        self.view2.layer.masksToBounds = false
        
        
        
        self.image2.layer.cornerRadius = 30
        
        self.image2.layer.shadowPath = UIBezierPath(roundedRect: self.image2.bounds, cornerRadius: self.image2.layer.cornerRadius).cgPath
        
        
        
        
        
        
        self.view21.layer.cornerRadius = 30
        
        self.view21.layer.shadowPath = UIBezierPath(roundedRect: self.view21.bounds, cornerRadius: self.view21.layer.cornerRadius).cgPath
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gobackclk(_ sender: UIButton) {
     
        dismiss(animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func animalbtnprssd(_ sender: UIButton) {
        myvalue = "animal"
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var secondViewcontroller = segue.destination as! ArViewChallegeController
        secondViewcontroller.whichguess = self.myvalue
    }
    
}
