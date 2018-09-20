//
//  ItemController.swift
//  Stuffy
//
//  Created by Adam on 31/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData

class ItemController {
    
    // This is a static method that belongs to the class so we do not need an instance
    
    static func createItemWith(category: Category, name: String, isFavorite: Bool, modelNumber: String, storePurchasedFrom: String, note: String, price: Double, quantity: Double, serialNumber: String, purchaseDate: Date, warrantyDate: Date, returnDate: Date) {
        let _ = Item(category: category, name: name, isFavorite: isFavorite, modelNumber: modelNumber, storePurchasedFrom: storePurchasedFrom, note: note, price: price, quantity: quantity, serialNumber: serialNumber, purchaseDate: purchaseDate, warrantyDate: warrantyDate, returnDate: returnDate)
        CoreDataStack.save()
    }
    static func createItemFrom(category: Category, tempItem: TempItem) {
        let item = Item(category: category, tempItem: tempItem)
        if tempItem.images.count > 1 {
            tempItem.images.forEach {
                if let image = $0 {
                    ImageController.createImageWith(image: image, to: item)
                }
            }
        }
        CoreDataStack.save()
    }
    static func update(category: Category, item: Item, name: String? = nil, isFavorite: Bool? = nil, modelNumber: String? = nil, storePurchasedFrom: String? = nil, note: String? = nil, price: Double? = nil, quantity: Double? = nil, serialNumber: String? = nil, purchaseDate: Date? = nil, warrantyDate: Date? = nil, returnDate: Date? = nil, images: [UIImage] = []) {
        item.category = category
        if let name = name {
            item.name = name
        }
        if let isFavorite = isFavorite {
            item.isFavorite = isFavorite
        }
        if let modelNumber = modelNumber {
            item.modelNumber = modelNumber
        }
        if let storePurchasedFrom = storePurchasedFrom {
            item.storePurchasedFrom = storePurchasedFrom
        }
        if let note = note {
            item.note = note
        }
        if let price = price {
            item.price = price
        }
        if let quantity = quantity {
            item.quantity = quantity
        }
        if let serialNumber = serialNumber {
            item.serialNumber = serialNumber
        }
        if let purchaseDate = purchaseDate {
            item.purchaseDate = purchaseDate
        }
        if let warrantyDate = warrantyDate {
            item.warrantyDate = warrantyDate
        }
        if let returnDate = returnDate {
            item.returnDate = returnDate
        }
        item.images = []
        for image in images {
            ImageController.createImageWith(image: image, to: item)
        }
        CoreDataStack.save()
    }
    
    static func updateFromTempItem(category: Category, item: Item, tempItem: TempItem) {
        item.category = category
        if let name = tempItem.name {
            item.name = name
        }
        if let isFavorite = tempItem.isFavorite {
            item.isFavorite = isFavorite
        }
        if let modelNumber = tempItem.modelNumber {
            item.modelNumber = modelNumber
        }
        if let storePurchasedFrom = tempItem.storePurchasedFrom {
            item.storePurchasedFrom = storePurchasedFrom
        }
        if let note = tempItem.note {
            item.note = note
        }
        if let price = tempItem.price {
            item.price = price
        }
        if let quantity = tempItem.quantity {
            item.quantity = quantity
        }
        if let serialNumber = tempItem.serialNumber {
            item.serialNumber = serialNumber
        }
        if let purchaseDate = tempItem.purchaseDate {
            item.purchaseDate = purchaseDate
        }
        if let warrantyDate = tempItem.warrantyDate {
            item.warrantyDate = warrantyDate
        }
        if let returnDate = tempItem.returnDate {
            item.returnDate = returnDate
        }
        item.images = []
        for image in tempItem.images {
            if let image = image {
                ImageController.createImageWith(image: image, to: item)
            }
        }
        CoreDataStack.save()
    }
    
    static func delete(item: Item, fromA category: Category) {
        guard let index = category.items?.index(of: item),
            let itemToDelete = category.items?.object(at: index) as? Item else { return }
        CoreDataStack.context.delete(itemToDelete)
        CoreDataStack.save()
    }
}
