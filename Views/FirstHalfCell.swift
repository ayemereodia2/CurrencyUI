//
//  FirstHalfCell.swift
//  CurrencyUI
//
//  Created by mac on 8/6/19.
//  Copyright © 2019 wox1. All rights reserved.
//

import UIKit

class FirstHalfCell: UITableViewCell,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyButton: UIButton!
    @IBOutlet weak var fromCurrencyButtn: UIButton!
    
    @IBOutlet weak var midButton: UIButton!
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()

    let countries:[String] = ["USA","NGR","POL","USA","NGR","POL","USA","NGR","POL","USA","NGR","POL","USA","NGR","POL"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        picker = UIPickerView.init()
        
        let color1 = hexStringToUIColor(hex: "#0080FF")//2DDE9F
        let color2 = hexStringToUIColor(hex: "#2DDE9F")//2DDE9F

        let attrs = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0),

            NSAttributedString.Key.foregroundColor : color1,
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        
        let attributedString = NSMutableAttributedString(string:"")
        
        let buttonTitleStr = NSMutableAttributedString(string:"Mid-market exchange rate at 13:38 UTC", attributes:attrs)
        attributedString.append(buttonTitleStr)
        midButton.setAttributedTitle(attributedString, for: [])

        
        let textSearch="."
        let textToShow="Currency Calculator."
        let rangeToColor = (textToShow as NSString).range(of: textSearch)
        let attributedString1 = NSMutableAttributedString(string:textToShow)
        attributedString1.addAttribute(NSAttributedString.Key.foregroundColor, value:color2 , range: rangeToColor)
        headingLabel.attributedText = attributedString1
        
        fromCurrencyTextField.delegate = self as UITextFieldDelegate
        fromCurrencyTextField.keyboardType = .decimalPad
        
        
        toCurrencyTextField.delegate = self as UITextFieldDelegate
        toCurrencyTextField.keyboardType = .decimalPad
        
    }
    
    @IBAction func FROM_CURRENCY__TAP_ACTION(_ sender: UIButton) {
        //picker = UIPickerView.init()
        //picker.delegate = self
        //picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        //picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .scaleAspectFit
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        //self.addSubview(toolBar)
    }
    
    
    @IBAction func TO_CURRENCY__TAP_ACTION(_ sender: UIButton) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        //picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .scaleAspectFit
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        //self.addSubview(toolBar)
    }
    
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print(countries[row])
        fromCurrencyButtn.titleLabel?.text = countries[row]
        fromLabel.text = countries[row]
    }
    

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.index(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 6
    }
}
