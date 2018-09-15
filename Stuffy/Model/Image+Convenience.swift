//
//  Image+Convenience.swift
//  Stuffy
//
//  Created by Adam on 30/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData

extension Image {
    convenience init(item: Item, imageData: Data, context:  NSManagedObjectContext = CoreDataStack.context) {
        // Initialize into the manage object context
        self.init(context: context)
        self.item = item
        self.imageData = imageData
    }
    
//    var image: UIImage?{
//    guard let imageData = imageData else {return nil}
//    return UIImage(data: imageData)
//    }
//    
//    image: UIImage
//
//    let imageData image.UIImage
//    self.imageData = imageData
}
