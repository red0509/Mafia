//
//  DistributionViewController.swift
//  Mafia
//
//  Created by Anton Pavlov on 01.09.16.
//  Copyright © 2016 Anton Pavlov. All rights reserved.
//

import UIKit

class DistributionViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonDistrib: UIButton!
    @IBOutlet weak var imageMap: UIImageView!
    
    
    var arrayPlayers = [Int]()
    var arrayPlayersTwo = [Int]()
    
    var hideMap = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Раздача карт"
        arrayPlayersTwo = arrayPlayers
        label.text = ""
        imageMap.image = UIImage.init(named: "back.png")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func animationImageMap(nameImage : String, textLabel : String){
        
        let time = 0.5
        
        UIView.animateWithDuration(time, animations: {
            self.imageMap.alpha = 0
            self.label.alpha = 0
        })
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            UIView.animateWithDuration(time, animations: {
                self.label.alpha = 1
                self.imageMap.alpha = 1
            })
            self.imageMap.image = UIImage.init(named: nameImage)
            self.label.text = textLabel
            
        }
        
    }
    
    
    @IBAction func ActionDistrib(sender: UIButton) {
        
        let emptyArray = Array(count: self.arrayPlayers.count, repeatedValue: 0)
        if arrayPlayers != emptyArray{
            self.buttonDistrib.setTitle( "Запомнил", forState: .Normal)
        }
        if hideMap {
            
            while arrayPlayers != emptyArray {
                let index = Int(arc4random_uniform(7))
                let random = arrayPlayers[index]
                if random == 0 {
                    continue
                }else{
                    
                    if index == 0{
                        
                        animationImageMap("citizen.png", textLabel: "Мирный житель")

                    }else if index == 1{

                        animationImageMap("commissar.png", textLabel: "Комиссар")
                        
                    }else if index == 2{

                        animationImageMap("mafia.png", textLabel: "Мафия")
                        
                    }else if index == 3{
                        
                        animationImageMap("donmafia.png", textLabel: "Дон мафии")
                        
                    }else if index == 4{
                        
                        animationImageMap("doctor.png", textLabel: "Доктор")
                        
                    }else if index == 5{
                        
                        animationImageMap("prostitute.png", textLabel: "Любовница")
                        
                    }else if index == 6{
                        
                        animationImageMap("maniac.png", textLabel: "Маньяк")
                    }
                    arrayPlayers[index] -= 1
                    print(arrayPlayers)
                    break
                }
            }
            hideMap = false
            
        }else{
            
            if arrayPlayers == emptyArray{
                
                animationImageMap("back.png", textLabel: "")
                
                let alert = UIAlertController(title: nil, message:  "Колода раздана", preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "Перераспределить колоду", style: .Default , handler: { (alert : UIAlertAction) in
                    self.navigationController?.popViewControllerAnimated(true)
                }))
                
                alert.addAction(UIAlertAction(title: "Заново", style: .Cancel, handler: { (alert : UIAlertAction) in
                    self.buttonDistrib.setTitle( "Начать раздачу", forState: .Normal)
                    self.arrayPlayers = self.arrayPlayersTwo
                    self.hideMap = true
                    
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }else{
                animationImageMap("back.png", textLabel: "")
                self.buttonDistrib.setTitle( "Открыть карту", forState: .Normal)
            }
            hideMap = true
        }
    }
}
