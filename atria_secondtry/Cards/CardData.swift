//
//  Entry.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/17/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import Foundation
import CoreData

public class CardData: NSManagedObject, Identifiable {
    
    @NSManaged public var name: String?
    @NSManaged public var picture: Data?
    @NSManaged public var classification: String?
    @NSManaged public var dateAdded: String?
    
}

extension CardData {
    
    static func getAllEntries() -> NSFetchRequest<CardData> {
        
        let request = NSFetchRequest<CardData>(entityName: "CardData")
        
        //maybe sort data by the date string, will add that text later
        //key is sort by date added, will go by sortdescriptor
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
}


