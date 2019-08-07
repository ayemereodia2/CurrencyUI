//
//  CurveBg.swift
//  CurrencyUI
//
//  Created by mac on 8/5/19.
//  Copyright © 2019 wox1. All rights reserved.
//

import UIKit

class BlueBgView: UIView {
    
    
    override func awakeFromNib() {
        layer.cornerRadius = 30
    }
}

class WhiteBgView: UIView {
    
    
    override func awakeFromNib() {
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 10
    }
}

class BlackBgButton: UIButton {
    
    override func awakeFromNib() {
        //layer.backgroundColor = UIColor.green.cgColor
        layer.cornerRadius = 5
    }
}

class CurveBlackButton: UIButton {
    
    override func awakeFromNib() {
        layer.borderColor = UIColor.groupTableViewBackground.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 5
    }
}


class FieldView: UITextField {
    
    
    override func awakeFromNib() {
        //layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 5
    }
}

