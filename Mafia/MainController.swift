//
//  ViewController.swift
//  Mafia
//
//  Created by Anton Pavlov on 31.08.16.
//  Copyright © 2016 Anton Pavlov. All rights reserved.
//

import UIKit
import SDCAlertView

class MainController: UIViewController, UIPickerViewDelegate ,UIPickerViewDataSource {
    
    
    var countPlayers = 0
    
    var pickerComponent = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Меню"
        
        for players in 6...20{
            pickerComponent.append("\(players)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //     MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showCountFromMain" {
            
            let controller = segue.destination as! CountTableViewController
            controller.detailItemFromMain = self.countPlayers
            
        }
    }
    
    // MARK: Action
    
    @IBAction func beginAction(_ sender: UIButton) {
        
        
        let alert = AlertController(title: "Начало", message:  "Выберете количество человек", preferredStyle: .alert)
        
        let contentView = alert.contentView
        
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(picker)
        if #available(iOS 9.0, *) {
            picker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            picker.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            picker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        
        alert.add(AlertAction(title: "Отмена", style: .preferred))
        alert.add(AlertAction(title: "OK", style: .normal, handler: { (alert : AlertAction) in
            
            self.countPlayers = picker.selectedRow(inComponent: 0)+6
            self.performSegue(withIdentifier: "showCountFromMain", sender: sender)
            
        }))
        
        alert.present()
        
    }
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerComponent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerComponent[row]
    }
    
    
    
    
}

