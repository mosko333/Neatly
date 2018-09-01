//
//  Item+Convenience.swift
//  Stuffy
//
//  Created by Adam on 30/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    convenience init(category: Category, name: String, isFavorite: Bool, modelNumber: String, storePurchasedFrom: String, note: String, price: Double, quantity: Double, serialNumber: String, purchaseDate: Date, warrantyDate: Date, returnDate: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        // initalizing the context for us to place our data into
        self.init(context: context)
        self.category = category
        self.name = name
        self.isFavorite = isFavorite
        self.modelNumber = modelNumber
        self.storePurchasedFrom = storePurchasedFrom
        self.note = note
        self.price = price
        self.quantity = quantity
        self.serialNumber = serialNumber
        self.purchaseDate = purchaseDate
        self.warrantyDate = warrantyDate
        self.returnDate = returnDate
    }
}
