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
    
    /*
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardData> {
        return NSFetchRequest<CardData>(entityName: "CardData")
    }
    */
    
    @NSManaged public var name: String?
    @NSManaged public var picture: Data?
    @NSManaged public var classification: String?
    
}

extension CardData {
    static func getAllEntries() -> NSFetchRequest<CardData> {
        //old bad
        //let request: NSFetchRequest<Entry> = Entry.fetchRequest() as! NSFetchRequest<Entry>
        
        //good one as searched up
        //let request: NSFetchRequest<Entry> = NSFetchRequest<Entry>(entityName: "Entry")
        let request = NSFetchRequest<CardData>(entityName: "CardData")
        
        //maybe sort data by the date string, will add that text later
        //key is sort by date added
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
    
}


