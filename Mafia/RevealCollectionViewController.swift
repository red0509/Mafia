//
//  RevealCollectionViewController.swift
//  Mafia
//
//  Created by Anton Pavlov on 06.10.16.
//  Copyright © 2016 Anton Pavlov. All rights reserved.
//

import UIKit
import SDCAlertView

private let reuseIdentifier = "cellReveal"

class RevealCollectionViewController: UICollectionViewController {
    
    var arrayPlayersName = [String]()
    var arrayPlayersMap = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Игроки"
        
    }
    
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPlayersName.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RevealCollectionViewCell
        cell.numberPlayersLabel.text = "\(indexPath.row+1)"
        cell.backgroundColor = UIColor(colorLiteralRed: 46/255, green: 125/255, blue: 50/255, alpha: 1)
        cell.layer.cornerRadius = 50
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        
        let alert = AlertController(title: self.arrayPlayersName[indexPath.row], message:  self.arrayPlayersName[indexPath.row], preferredStyle: .alert)
        
        let contentView = alert.contentView
        
        let image = UIImageView(image: UIImage(named: self.arrayPlayersMap[indexPath.row] ))
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        
        if #available(iOS 9.0, *) {
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        
        alert.add(AlertAction(title: "OK", style: .normal, handler: { (alert : AlertAction) in
            UIView.animate(withDuration: 0.5, animations: {
                collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(colorLiteralRed: 198/255, green: 40/255, blue: 40/255, alpha: 1)
            })
            
        }))
        
        alert.present()
        
        
    }
}
