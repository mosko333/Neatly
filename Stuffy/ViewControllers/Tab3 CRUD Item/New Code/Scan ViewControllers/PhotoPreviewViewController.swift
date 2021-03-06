//
//  PhotoPreviewViewController.swift
//  Stuffy
//
//  Created by Adam on 03/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//
import UIKit

class PhotoPreviewViewController: UIViewController {
    
    //////////////////////
    // TODO: Replace With Model
    //////////////////////
    var photo: UIImage?
//    var categoryPicked: Category?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    @IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
        //performSegue(withIdentifier: "UnwindToAddItem", sender: self)
//       performSegue(withIdentifier: "toNewAddItemVC", sender: self)
//        guard let photo = photo else {return}
//        print("recepit save button pressed")
//        CoreDataController.shared.photos.append(photo)
    }
    
    func updateView() {
        //////////////////////
        // TODO: Replace
        //////////////////////
        DispatchQueue.main.async {
            self.photoImageView.image = self.photo
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! AddItemTableViewController
        destVC.tempItem.images.append(photo)
//        if segue.identifier == "toNewAddItemVC"{
//          let destinationVC = segue.destination as! UINavigationController
//            let topVC = destinationVC.topViewController as! AddItemTableViewController
//            topVC.tempItem.images.append(photo)
////            topVC.categoryPicked = categoryPicked
//        }
    }
    
}
