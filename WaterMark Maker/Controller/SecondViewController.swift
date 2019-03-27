//
//  SecondViewController.swift
//  WaterMark Maker
//
//  Created by Mac on 10/20/18.
//  Copyright © 2018 com.lss.pk. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
   let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var TExtView1: UITextView!
    
    @IBOutlet weak var sliderFont: UISlider!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TExtView1.placeholder = "Add Text here!"
    }
    
    @IBAction func FontSizer(_ sender: UISlider) {
//        print(sender.value)
        if sender.value == 0.0{
            self.TExtView1.font = UIFont.systemFont(ofSize: 32.0)
            
//
            
        }else{
            
            
            self.TExtView1.font = UIFont.systemFont(ofSize: CGFloat(sender.value + 32.0))
        print(UIFont.systemFont(ofSize: CGFloat(sender.value + 32)))
            appdelegate.fontSize = UIFont.systemFont(ofSize: CGFloat(sender.value + 32))
        }
        
        
//        let fontSize = CGFloat(sender.value * 32)
//        sliderFont.minimumValue = Float(fontSize)
//        TExtView1.font = UIFont(name: (TExtView1.font?.fontName)!, size: fontSize)

        
        
        
//        let senderValue = CGFloat(sender.value)
//        TExtView1.font = UIFont(name: (TExtView1.font?.familyName)!, size: senderValue)
    }
    
    
    @IBAction func ColourSliderAction(_ sender: Any) {
        
        
        
        
        
        appdelegate.fontColour = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
        
        TExtView1.textColor = appdelegate.fontColour
//        TExtView1.textColor = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
        
    
    }
    
    
    @IBAction func SaveButton(_ sender: Any) {
     self.appdelegate.newData = self.TExtView1.text!
    self.appdelegate.fontColour = self.TExtView1.textColor!
        self.dismiss(animated: true, completion: nil)
    }
   

}
