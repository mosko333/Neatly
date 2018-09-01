//
//  CategoryController.swift
//  Stuffy
//
//  Created by Adam on 30/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation
import CoreData

class CategoryController {
    
    // steps to think of when making model controller
    // 1) CRUD
    // 2) SOURCE OF TRUTH
    // 3) SharedInstance
    
    // this is our shared instance to get everything inside this class
    static let shared = CategoryController()
    
    /// This is our source of TRUTH!!!
    var categories: [Category] {
        
        // we define out request of what we would like to get back. then we tell it to perform that request
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        // WE ALLWAYS NEED TO talk to our context first, in order to get what object we want out of it
        guard let categoryArray = try? CoreDataStack.context.fetch(request) else {
            print("❌ Error fetching categories from core data"); return [] }
        if categoryArray.count == 0 {
            print("Creating initial category")
            create(categoryName: "General")
            return (try? CoreDataStack.context.fetch(request)) ?? []
        }
        return categoryArray
    }
    
    //C
    func create(categoryName: String) {
        // 1) create an instance "Think initalizer"
        Category(name: categoryName, isFavorite: false)
        CoreDataStack.save()
    }
    
    //R
    
    //U
    func update(category: Category, newName: String) {
        category.name = newName
        CoreDataStack.save()
    }
    
    //D
    func delete(category: Category) {
        CoreDataStack.context.delete(category)
        CoreDataStack.save()
    }
}
