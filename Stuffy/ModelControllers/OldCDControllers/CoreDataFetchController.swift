//
//  CoreDataFetchController.swift
//  Stuffy
//
//  Created by Hayden Murdock on 7/30/18.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation
import CoreData

class CoreDataFetchController {
    
   static let shared = CoreDataFetchController()
    
    func fetchAllCategories() -> [Category]{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
    
        let results = try? CoreDataStack.context.fetch(fetchRequest)
        
        return results as! [Category]
    }
    
    func fetchAllItems() -> [Item] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        let results = try? CoreDataStack.context.fetch(fetchRequest)
        
        return results as! [Item]
    }
}
