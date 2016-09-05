//
//  CountTableViewController.swift
//  Mafia
//
//  Created by Anton Pavlov on 31.08.16.
//  Copyright © 2016 Anton Pavlov. All rights reserved.
//

import UIKit
import CoreData


class CountTableViewController: UITableViewController {
    
    var countPlayers = 0
    var player : valuePlayers!
    var countMap : Int {
        return 7
    }
    
    //  MARK: - Master
    
    var detailItemFromMaster: Map?
    
    func configureViewFromMaster() {
        if let detail = self.detailItemFromMaster {
            
            player = valuePlayers(citizen: detail.cardDeck[0] , commissioner: detail.cardDeck[1], mafia: detail.cardDeck[2], donMafia: detail.cardDeck[3], doctor: detail.cardDeck[4], prostitute: detail.cardDeck[5], maniac: detail.cardDeck[6])
            print( player)
            
            for elem in detail.cardDeck{
                countPlayers += elem
            }
        }
    }
    
    //  MARK: - Main
    
    var detailItemFromMain: Int?
    
    func configureViewFromMain() {
        if let detail = self.detailItemFromMain {
            countPlayers = detail
            let mafia = countPlayers/3
            if countPlayers >= 8{
                player = valuePlayers(citizen: countPlayers - 3 - mafia , commissioner: 1, mafia: mafia - 1, donMafia: 1, doctor: 1, prostitute: 1, maniac: 0)
            }else{
                player = valuePlayers(citizen: countPlayers - 1 - mafia , commissioner: 1, mafia: mafia - 1, donMafia: 1, doctor: 0, prostitute: 0, maniac: 0)
            }
        }
    }
    
    
    struct valuePlayers {
        var citizen : Int
        var commissioner : Int
        var mafia : Int
        var donMafia : Int
        var doctor : Int
        var prostitute : Int
        var maniac : Int
        
        subscript(index: Int) -> Int {
            
            let player = valuePlayers(citizen: self.citizen, commissioner: self.commissioner, mafia: self.mafia, donMafia: self.donMafia, doctor: self.doctor, prostitute: self.prostitute, maniac: self.maniac)
            
            if index == 0 {
                return player.citizen
            }else if index == 1 {
                return player.commissioner
            }else if index == 2 {
                return player.mafia
            }else if index == 3 {
                return player.donMafia
            }else if index == 4 {
                return player.doctor
            }else if index == 5 {
                return player.prostitute
            }else if index == 6 {
                return player.maniac
            }else{
                return 21
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Колода"
        
        self.configureViewFromMain()
        self.configureViewFromMaster()
        
        let button = UIBarButtonItem(title: "Готово", style: .Plain, target: self, action: #selector(readyButton(_:)))
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
        
        self.navigationItem.rightBarButtonItems = [button , addButton]
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func readyButton(sender : UIBarButtonItem)  {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DistributionViewController") as! DistributionViewController
        for i in 0..<countMap{
            vc.arrayPlayers.append(player[i])
        }
        
        self.navigationController?.showViewController(vc, sender: vc)
        
    }
    func insertNewObject(sender: AnyObject) {
        
        var arrayMap = [Int]()
        
        let managedObjectContext =  DataManager.sharedInstance.managedObjectContext
        
        let map = NSEntityDescription.insertNewObjectForEntityForName("Map", inManagedObjectContext: managedObjectContext) as! Map
        countPlayers = 0
        for i in 0..<countMap{
            countPlayers += player[i]
        }
        
        map.title = "Колода на \(countPlayers) человек"
        for i in 0..<countMap{
            arrayMap.append(player[i])
        }
        map.cardDeck = arrayMap
        
        do {
            try managedObjectContext.save()
            let alert = UIAlertController(title: "Начало", message:  "Выберете количество человек", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        } catch {
            abort()
        }
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let allPlayers = player.citizen + player.commissioner + player.mafia + player.donMafia + player.doctor + player.prostitute + player.maniac
        let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 18))
        let label = UILabel(frame: CGRectMake(10, 5, tableView.frame.size.width, 18))
        label.font = UIFont.systemFontOfSize(14)
        view.addSubview(label)
        view.backgroundColor = UIColor.whiteColor()
        if allPlayers == countPlayers {
            label.text = "Колода готова к игре"
            return view
        }else if allPlayers > countPlayers{
            label.text = "В колоде на \(allPlayers - countPlayers) персонажа(ей) больше"
            return view
        }else {
            label.text = "В колоде на \(countPlayers - allPlayers) персонажа(ей) меньше"
            return view
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countMap
    }
    
    @IBAction func stepperAction(sender: UIStepper) {
        
        let value = Int(sender.value)
        let cursorPosition = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(cursorPosition)
        let currentCell = self.tableView .cellForRowAtIndexPath(indexPath!) as! CountTableCell
        currentCell.count.text = "\(value)"
        self.tableView.reloadData()
        if indexPath!.row == 0{
            self.player.citizen = value
            
        }else if indexPath!.row == 1{
            
            self.player.commissioner = value
            
        }else if indexPath!.row == 2{
            
            self.player.mafia = value
            
        }else if indexPath!.row == 3{
            
            self.player.donMafia = value
            
        }else if indexPath!.row == 4{
            
            self.player.doctor = value
            
        }else if indexPath!.row == 5{
            
            self.player.prostitute = value
            
        }else if indexPath!.row == 6{
            
            self.player.maniac = value
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("countCell", forIndexPath: indexPath) as! CountTableCell
        if indexPath.row == 0{
            cell.name.text = "Мирный житель"
            cell.stepper.value = Double(self.player.citizen)
            cell.count.text = "\(self.player.citizen)"
        }else if indexPath.row == 1{
            cell.name.text = "Комиссар"
            cell.stepper.value = Double(self.player.commissioner)
            cell.count.text = "\(self.player.commissioner)"
        }else if indexPath.row == 2{
            cell.name.text = "Мафия"
            cell.stepper.value = Double(self.player.mafia)
            cell.count.text = "\(self.player.mafia)"
        }else if indexPath.row == 3{
            cell.name.text = "Дон мафии"
            cell.stepper.value = Double(self.player.donMafia)
            cell.count.text = "\(self.player.donMafia)"
        }else if indexPath.row == 4{
            cell.name.text = "Доктор"
            cell.stepper.value = Double(self.player.doctor)
            cell.count.text = "\(self.player.doctor)"
        }else if indexPath.row == 5{
            cell.name.text = "Любовница"
            cell.stepper.value = Double(self.player.prostitute)
            cell.count.text = "\(self.player.prostitute)"
        }else if indexPath.row == 6{
            cell.name.text = "Маньяк"
            cell.stepper.value = Double(self.player.maniac)
            cell.count.text = "\(self.player.maniac)"
        }
        
        return cell
    }
    
}
