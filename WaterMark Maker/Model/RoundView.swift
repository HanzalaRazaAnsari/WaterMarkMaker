//
//  RoundView.swift
//  EmergencyCall(Driver)
//
//  Created by HanZala RaZa on 7/3/18.
//  Copyright © 2018 HanZala RaZa. All rights reserved.
//


import UIKit

@IBDesignable class RoundView: UITextView{
        override func draw(_ rect: CGRect) {
            // Drawing code
         self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
            
        }
        @IBInspectable var borderWidth: CGFloat = 0 {
            didSet {
                layer.borderWidth = self.borderWidth
            }
        }
        @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = self.cornerRadius
                layer.masksToBounds = self.cornerRadius > 0
        }
        
        // Do any additional setup after loading the view.
    }

}
