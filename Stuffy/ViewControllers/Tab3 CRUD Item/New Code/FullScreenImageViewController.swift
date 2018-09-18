//
//  FullScreenImageViewController.swift
//  Stuffy
//
//  Created by Adam on 16/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    //
    // MARK: - Properties
    //
    var tempItem: TempItem?
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        pageController.numberOfPages = tempItem?.images.count ?? 1
    }
    //
    // MARK: - Actions
    //
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

//
// MARK: - Extensions
//
extension FullScreenImageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let tempItem = tempItem,
            tempItem.images.count > 0 {
            return tempItem.images.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! FullScreenImageCollectionViewCell
        if let tempItem = tempItem,
            tempItem.images.count > 0 {
            cell.itemImageView.image = tempItem.images[indexPath.row]
        } else {
            cell.itemImageView.image = #imageLiteral(resourceName: "xcaCameraCellDefaultImage")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width = UIScreen.main.bounds.width
        let width = collectionView.bounds.width
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageController.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}











