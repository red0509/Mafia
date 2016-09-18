//
//  Map+CoreDataProperties.swift
//  Mafia
//
//  Created by Anton Pavlov on 05.09.16.
//  Copyright © 2016 Anton Pavlov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Map {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Map> {
        return NSFetchRequest<Map>(entityName: "Map");
    }

    @NSManaged var title: String?
    @NSManaged var cardDeck: [Int]

}
