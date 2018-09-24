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
    //
    // MARK: - Properties
    //
    static let shared = CategoryController()
    var categories: [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        guard let categoryArray = try? CoreDataStack.context.fetch(request) else {
            print("❌ Error fetching categories from core data"); return [] }
        if categoryArray.count == 0 {
            print("Creating initial category")
            create(categoryName: "General")
            return (try? CoreDataStack.context.fetch(request)) ?? []
        }
        return categoryArray
    }
    
    var sortedCategoriesFavorites: [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        //let favoriteSort = NSSortDescriptor(key: "isFavorite", ascending: true)
        //request.sortDescriptors = [favoriteSort]
        let isFavoritePredicate = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))
        request.predicate = isFavoritePredicate
        guard let categoryArray = try? CoreDataStack.context.fetch(request) else {
            print("❌ Error fetching categories from core data"); return [] }
        return categoryArray
    }
    
    //
    // MARK: - Methods
    //
    func create(categoryName: String) {
        // 1) create an instance "Think initalizer"
        Category(name: categoryName, isFavorite: false)
        CoreDataStack.save()
    }

    func update(category: Category, newName: String) {
        category.name = newName
        CoreDataStack.save()
    }

    func delete(category: Category) {
        CoreDataStack.context.delete(category)
        CoreDataStack.save()
    }
    
    func searchCategoriesBy(searchTerm: String) -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        let searchPredicate = NSPredicate(format: "name contains[c] '\(searchTerm)'")
        request.predicate = searchPredicate
        guard let categoryArray = try? CoreDataStack.context.fetch(request) else {
            print("❌ Error fetching categories from core data"); return [] }
        return categoryArray
    }
}
