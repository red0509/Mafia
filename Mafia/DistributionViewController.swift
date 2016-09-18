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
    
    func animationImageMap(_ nameImage : String, textLabel : String){
        
        let time = 0.5
        
        UIView.animate(withDuration: time, animations: {
            self.imageMap.alpha = 0
            self.label.alpha = 0
        })
        let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            UIView.animate(withDuration: time, animations: {
                self.label.alpha = 1
                self.imageMap.alpha = 1
            })
            self.imageMap.image = UIImage.init(named: nameImage)
            self.label.text = textLabel
            
        }
        
    }
    
    
    @IBAction func ActionDistrib(_ sender: UIButton) {
        
        let emptyArray = Array(repeating: 0, count: self.arrayPlayers.count)
        if arrayPlayers != emptyArray{
            self.buttonDistrib.setTitle( "Запомнил", for: UIControlState())
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
                
                let alert = UIAlertController(title: nil, message:  "Колода раздана", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Перераспределить колоду", style: .default , handler: { (alert : UIAlertAction) in
//                    self.navigationController?.popViewController(animated: true)
                    let _ = self.navigationController?.popViewController(animated: true)
                }))
                
                alert.addAction(UIAlertAction(title: "Заново", style: .cancel, handler: { (alert : UIAlertAction) in
                    self.buttonDistrib.setTitle( "Начать раздачу", for: UIControlState())
                    self.arrayPlayers = self.arrayPlayersTwo
                    self.hideMap = true
                    
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            }else{
                animationImageMap("back.png", textLabel: "")
                self.buttonDistrib.setTitle( "Открыть карту", for: UIControlState())
            }
            hideMap = true
        }
    }
}
