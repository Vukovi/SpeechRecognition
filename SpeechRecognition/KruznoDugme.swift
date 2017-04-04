//
//  KruznoDugme.swift
//  SpeechRecognition
//
//  Created by Vuk Knezevic on 4/4/17.
//  Copyright © 2017 Vuk Knezevic. All rights reserved.
//

import UIKit

@IBDesignable
class KruznoDugme: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet{ //ovaj didSet mora da se postavi kod @IBInspectable
            //layer.cornerRadius = cornerRadius
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }

}
