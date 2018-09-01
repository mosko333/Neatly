//
//  Category+Convenience.swift
//  Stuffy
//
//  Created by Adam on 30/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation
import CoreData

extension Category {
    @discardableResult convenience init (name: String, isFavorite: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        // initalizing the context for us to place our data into
        self.init(context: context)
        self.name = name
        self.isFavorite = isFavorite
    }
}
