//
//  LandingVC.swift
//  CurrencyUI
//
//  Created by mac on 8/6/19.
//  Copyright © 2019 wox1. All rights reserved.
//

import UIKit

class LandingVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var tableLanding: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableLanding.delegate = self
        tableLanding.dataSource = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        tableLanding.register(UINib(nibName: "FirstHalfCell", bundle: nil), forCellReuseIdentifier: "FirstHalfCell")
         tableLanding.register(UINib(nibName: "SecondHalfCell", bundle: nil), forCellReuseIdentifier: "SecondHalfCell")
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FirstHalfCell", for: indexPath) as? FirstHalfCell
            {
               // cell.picker.delegate = self
                //cell.picker.dataSource = self
                return cell
                
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondHalfCell", for: indexPath) as? SecondHalfCell
            {
                return cell
                
            }
        default:
            return UITableViewCell()

        }
        return UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath[0] == 0 {
            return 413
        }
        else{
            return 240

        }
        
    }

}

