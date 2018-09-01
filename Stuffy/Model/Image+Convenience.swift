//
//  Image+Convenience.swift
//  Stuffy
//
//  Created by Adam on 30/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation
import CoreData

extension Image {
    convenience init(item: Item, imageData: Data, context:  NSManagedObjectContext = CoreDataStack.context) {
        // Initialize into the manage object context
        self.init(context: context)
        self.item = item
        self.imageData = imageData
    }
}
