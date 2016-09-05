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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showCountFromMain" {
            
            let controller = segue.destinationViewController as! CountTableViewController
            controller.detailItemFromMain = self.countPlayers
            
        }
    }
    
    // MARK: Action
    
    @IBAction func beginAction(sender: UIButton) {
        
        
        let alert = AlertController(title: "Начало", message:  "Выберете количество человек", preferredStyle: .Alert)
        
        let contentView = alert.contentView
        
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(picker)
        picker.centerXAnchor.constraintEqualToAnchor(contentView.centerXAnchor).active = true
        picker.topAnchor.constraintEqualToAnchor(contentView.topAnchor).active = true
        picker.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor).active = true
        
        alert.addAction(AlertAction(title: "Отмена", style: .Preferred))
        
        alert.addAction(AlertAction(title: "OK", style: .Default, handler: { (alert : AlertAction) in
            
            self.countPlayers = picker.selectedRowInComponent(0)+6
            self.performSegueWithIdentifier("showCountFromMain", sender: sender)
            
        }))
        
        //        if #available(iOS 9, *) {
        //        }
        alert.present()
        
    }
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerComponent.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerComponent[row]
    }
    
    
    
    
}

