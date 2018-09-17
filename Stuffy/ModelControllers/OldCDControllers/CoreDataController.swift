//
//  ItemCoreDataController.swift
//  Stuffy
//
//  Created by Hayden Murdock on 6/25/18.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation
import UIKit

class CoreDataController {
    
    static let shared = CoreDataController()
    
    // This array holds all the categories
    
    var allCategories: [Category] = []
    // This array holds all the Items
    
    var items: [Item] = []
    // this array holds photos to be saved for the add item tableViewController
    
    var photos: [UIImage] = [] {
        didSet {
            print ("photo was added to to photos array")
        }
    }
    
    func createItem(category: Category, photos: [UIImage], name: String, isFavorite: Bool, returnDate: Date, modelNumber: String, note: String, price: Double, storePurchasedFrom: String, quantity: Double, serialNumber: String, warrantyDate: Date, purchaseDate: Date ) {
        
        let item = Item(category: category, name: name, isFavorite: isFavorite, modelNumber: modelNumber, storePurchasedFrom: storePurchasedFrom, note: note, price: price, quantity: quantity, serialNumber: serialNumber, purchaseDate: purchaseDate, warrantyDate: warrantyDate, returnDate: returnDate)
        
        
        item.category = category
        
        createImage(item: item, images: photos)
        
        CoreDataController.shared.items.append(item)
       
        CoreDataStack.save()
    }
    
    
    func deleteItem(with item: Item) {
        
        if (item.images?.count)! > 0 {
            guard let imagesToDelete = item.images?.array as? [Image] else { return }
            for image in imagesToDelete {
                
                deleteImage(with: image)
            }
        }
        
        CoreDataStack.context.delete(item)
    
        CoreDataStack.save()
        
    }
    
//    func createCategory(name: String){
//        
//        let categoryName = name.trimmingCharacters(in: .whitespaces)
//        
//      let category = Category(name: categoryName, isFavorite: false)
//        CoreDataController.shared.allCategories.append(category)
//        
//        CoreDataStack.save()
//    }
    
    func deleteCategory(with category: Category){
        
        if (category.items?.count)! > 0 {
            guard let itemsToDelete = category.items?.array as? [Item] else { return }
            for item in itemsToDelete{
                deleteItem(with: item)
        }
        CoreDataStack.context.delete(category)
    
        CoreDataStack.save()
       

       }
   }
    
    func createImage(item: Item, images: [UIImage]){
        for image in images{
            
            let createdImage = Image(item: item, image: image)
            
            createdImage.item = item
        }
    }
    
    func deleteImage(with image: Image){
        
        CoreDataStack.context.delete(image)
        
        CoreDataStack.save()
    }
}
