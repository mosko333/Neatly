//
//  ImageController.swift
//  Stuffy
//
//  Created by Adam on 31/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData

class ImageController {
    
    // This is a static method that belongs to the class so we do not need an instance
    static func createImageWith(image: UIImage, to item: Item) {
        let _ = Image(item: item, image: image)
        CoreDataStack.save()
    }
    
    static func update(image: Image, newPictuer: UIImage) {
        guard let imageData = newPictuer.jpegData(compressionQuality: 0.5) else { return }
        image.imageData = imageData
        CoreDataStack.save()
    }
    
    static func delete(image: Image, fromA item: Item) {
        guard let index = item.images?.index(of: image),
            let imageToDelete = item.images?.object(at: index) as? Image else { return }
        CoreDataStack.context.delete(imageToDelete)
        CoreDataStack.save()
    }
}
