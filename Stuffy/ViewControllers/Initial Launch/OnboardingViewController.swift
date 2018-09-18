//
//  OnboardingViewController.swift
//  Stuffy
//
//  Created by Adam on 17/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var skipDoneBtn: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    //
    // MARK: - Actions
    //
    @IBAction func skipDoneBtnTapped(_ sender: UIButton) {
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageController.numberOfPages = 3
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstOnboarding", for: indexPath)/* as! FirstOnboardCollectionViewCell*/
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondOnboarding", for: indexPath)
            return cell
        } else if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdOnboarding", for: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageController.currentPage = indexPath.row
    }
}
