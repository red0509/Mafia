//
//  CountTableViewController.swift
//  Mafia
//
//  Created by Anton Pavlov on 31.08.16.
//  Copyright © 2016 Anton Pavlov. All rights reserved.
//

import UIKit


class CountTableViewController: UITableViewController {
    
    var countPlayers = 0
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
    
    var player : valuePlayers!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Колода"
        
        let mafia =  countPlayers/3
        if countPlayers >= 8{
            player = valuePlayers(citizen: countPlayers - 3 - mafia , commissioner: 1, mafia: mafia - 1, donMafia: 1, doctor: 1, prostitute: 1, maniac: 0)
        }else{
            player = valuePlayers(citizen: countPlayers - 1 - mafia , commissioner: 1, mafia: mafia - 1, donMafia: 1, doctor: 0, prostitute: 0, maniac: 0)
        }
        
        let button = UIBarButtonItem(title: "Готово", style: .Plain, target: self, action: #selector(readyButton(_:)))
        
        self.navigationItem.rightBarButtonItem = button
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func readyButton(sender : UIBarButtonItem)  {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DistributionViewController") as! DistributionViewController
        for i in 0..<7{
            vc.arrayPlayers.append(player[i])
        }
        
        self.navigationController?.showViewController(vc, sender: vc)
        
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
        return 7
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
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
