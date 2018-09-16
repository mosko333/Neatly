//
//  TempItem.swift
//  Stuffy
//
//  Created by Adam on 14/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

struct TempItem {
        var category: Category? = nil
        var name: String? = nil
        var isFavorite: Bool? = nil
        var modelNumber: String? = nil
        var storePurchasedFrom: String? = nil
        var note: String? = nil
        var price: String? = nil
        var quantity: Double? = 1.0
        var serialNumber: String? = nil
        var purchaseDate: Date? = nil
        var warrantyDate: Date? = nil
        var returnDate: Date? = nil
        var images: [UIImage?] = []
}
