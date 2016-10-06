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
    var arrayPlayersName = [String]()
    var arrayPlayersMap = [String]()
    
    var number : Int = 1
    var hideMap = true
    var countMap : Int {
        return 7
    }
    
    enum PersonName : String {
        case citizen = "Мирный житель"
        case commissar = "Комиссар"
        case mafia = "Мафия"
        case donMafia = "Дон мафии"
        case doctor = "Доктор"
        case prostitute = "Любовница"
        case maniac = "Маньяк"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Раздача карт"
        
        buttonDistrib.layer.cornerRadius = 9
        
        arrayPlayersTwo = arrayPlayers
        label.text = ""
        imageMap.image  = UIImage(named: "back.png")
        
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showReveal"{
            
            let controller = segue.destination as! RevealCollectionViewController
            controller.arrayPlayersName = self.arrayPlayersName
           controller.arrayPlayersMap = self.arrayPlayersMap
        }
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
            self.imageMap.image = UIImage(named: nameImage)
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
                let index = Int(arc4random_uniform(UInt32(countMap)))
                let random = arrayPlayers[index]
                if random == 0 {
                    continue
                }else{
                    switch index {
                    case 0:
                        animationImageMap("citizen.png", textLabel: "Игрок №\(number)\n\(PersonName.citizen.rawValue)")
                        self.arrayPlayersName.append(PersonName.citizen.rawValue)
                        self.arrayPlayersMap.append("citizen.png")
                    case 1:
                        animationImageMap("commissar.png", textLabel: "Игрок №\(number)\n\(PersonName.commissar.rawValue)")
                        self.arrayPlayersName.append(PersonName.commissar.rawValue)
                        self.arrayPlayersMap.append("commissar.png")
                    case 2:
                        animationImageMap("mafia.png", textLabel: "Игрок №\(number)\n\(PersonName.mafia.rawValue)")
                        self.arrayPlayersName.append(PersonName.mafia.rawValue)
                        self.arrayPlayersMap.append("mafia.png")
                    case 3:
                        animationImageMap("donmafia.png", textLabel: "Игрок №\(number)\n\(PersonName.donMafia.rawValue)")
                        self.arrayPlayersName.append(PersonName.donMafia.rawValue)
                        self.arrayPlayersMap.append("donmafia.png")
                    case 4:
                        animationImageMap("doctor.png", textLabel: "Игрок №\(number)\n\(PersonName.doctor.rawValue)")
                        self.arrayPlayersName.append(PersonName.doctor.rawValue)
                        self.arrayPlayersMap.append("doctor.png")
                    case 5:
                        animationImageMap("prostitute.png", textLabel: "Игрок №\(number)\n\(PersonName.prostitute.rawValue)")
                        self.arrayPlayersName.append(PersonName.prostitute.rawValue)
                        self.arrayPlayersMap.append("prostitute.png")
                    case 6:
                        animationImageMap("maniac.png", textLabel: "Игрок №\(number)\n\(PersonName.maniac.rawValue)")
                        self.arrayPlayersName.append(PersonName.maniac.rawValue)
                        self.arrayPlayersMap.append("maniac.png")
                    default: break
                    }
                    
                    number += 1
                    arrayPlayers[index] -= 1
                    break
                }
            }
            hideMap = false
            
        }else{
            
            if arrayPlayers == emptyArray{
                
                animationImageMap("back.png", textLabel: "")
                
                let alert = UIAlertController(title: nil, message:  "Колода раздана", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Перераспределить колоду", style: .default , handler: { (alert : UIAlertAction) in
                    let _ = self.navigationController?.popViewController(animated: true)
                }))
                
                alert.addAction(UIAlertAction(title: "Заново", style: .default, handler: { (alert : UIAlertAction) in
                    print(self.arrayPlayersName)
                    self.arrayPlayersName = []
                    self.number = 1
                    self.buttonDistrib.setTitle( "Начать раздачу", for: UIControlState())
                    self.arrayPlayers = self.arrayPlayersTwo
                    self.hideMap = true
                    
                }))
                
                alert.addAction(UIAlertAction(title: "Начать игру", style: .cancel, handler: { (alert : UIAlertAction) in
                        self.performSegue(withIdentifier: "showReveal", sender: nil)
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
