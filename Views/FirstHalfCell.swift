//
//  FirstHalfCell.swift
//  CurrencyUI
//
//  Created by mac on 8/6/19.
//  Copyright © 2019 wox1. All rights reserved.
//

import UIKit

class FirstHalfCell: UITableViewCell,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var fromCurrencyButton: CurveBlackButton!
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var toCurrencyButton: CurveBlackButton!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    
    @IBOutlet weak var midButton: UIButton!
    
    var api = FixerService()
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var buttonToggle:Bool = false
    var fromString = ""
    var toString = ""
    
    let countries:[String] = ["GBP","JPY","CAD","USD","AUD","EUR","NGN","SEK","CFA"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        picker = UIPickerView.init()
        
        let color1 = hexStringToUIColor(hex: "#0080FF")
        let color2 = hexStringToUIColor(hex: "#2DDE9F")

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
        
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .scaleAspectFit
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        picker.isUserInteractionEnabled = true
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        
        
    }
    
    
    
    @IBAction func FROM_CURRENCY__TAP_ACTION(_ sender: UIButton) {
        self.superview?.addSubview(picker)
        self.superview?.addSubview(toolBar)
        buttonToggle = true
    }
    
    
    @IBAction func TO_CURRENCY__TAP_ACTION(_ sender: UIButton) {
        self.superview?.addSubview(picker)
        self.superview?.addSubview(toolBar)
        buttonToggle = false
    }
    
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        fromString = fromCurrencyTextField.text!
        toString = toCurrencyTextField.text!
        
        
        
    }
    
    func setUpView(resp:ConvertionResp) {
        
        toCurrencyTextField.text = resp.result.description
    }
    
    
    @IBAction func convertValues(_ sender: Any) {
        
        self.spinner.startAnimating()
        let qr = Query(from:"USD",to:"GBP",amount:25)
        
        api.convert(payload: qr) { (resp) in
            
            if let resp = resp {
                self.spinner.stopAnimating()
                self.setUpView(resp: resp)
                
            }
            else{
                self.spinner.stopAnimating()
                self.showAlert()
            }
        }
        
        
    }
    
    func showAlert() {
    
        let refreshAlert = UIAlertController(title: "Message", message: "Your Fixer.io subscripption does not allow this method", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (UIAlertAction) in
            
        }))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(refreshAlert, animated: true, completion: nil)

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
        if buttonToggle {
            fromCurrencyButton.setTitle(countries[row], for: .normal)
            fromLabel.text = countries[row]
        }
        else{
            toCurrencyButton.setTitle(countries[row], for: .normal)
            toLabel.text = countries[row]
        }
        
        
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
