//
//  TempItem.swift
//  Stuffy
//
//  Created by Adam on 14/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class TempItem {
        var category: Category? = nil
        var name: String? = nil
        var isFavorite: Bool? = false
        var modelNumber: String? = nil
        var storePurchasedFrom: String? = nil
        var note: String? = nil
        var price: Double? = 0
        var quantity: Double? = 1.0
        var serialNumber: String? = nil
        var purchaseDate: Date? = nil
        var warrantyDate: Date? = nil
        var returnDate: Date? = nil
        var images: [UIImage?] = []
    
    init() {
    }
    
    convenience init(item: Item) {
        self.init()
        self.category = item.category
        self.name = item.name
        self.isFavorite = item.isFavorite
        self.modelNumber = item.modelNumber
        self.storePurchasedFrom = item.storePurchasedFrom
        self.note = item.note
        self.price = item.price
        self.quantity = item.quantity
        self.serialNumber = item.serialNumber
        self.purchaseDate = item.purchaseDate
        self.warrantyDate = item.warrantyDate
        self.returnDate = item.returnDate
        
        // Handling the Images
        var imageArray: [UIImage?] = []
        if let images = item.images {
            for object in images {
                if let object = object as? Image {
                    imageArray.append(object.image)
                }
            }
        }
        self.images = imageArray
    }
}
