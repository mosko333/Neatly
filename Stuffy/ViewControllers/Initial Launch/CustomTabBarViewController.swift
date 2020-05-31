//
//  CustomTabBarViewController.swift
//  Stuffy
//
//  Created by Adam on 26/06/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController, CustomTabBarViewMainDelegate {
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var tabView: CustomTabBarMainView!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    //
    // MARK: - Methods
    //
    func setupTabBar() {
        tabView.delegate = self
        selectedIndex = 0
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.addShadow()
        view.addSubview(tabView)
        
        let leadingConstraint = tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottomConstraint = tabView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 34.0) //to extend behind the iPhone X home indicator
        let heightConstraint = tabView.heightAnchor.constraint(equalToConstant: 104.0) //includes 34.0 points for iPhone X home indicator
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, bottomConstraint, heightConstraint])
    }
    //
    // MARK: - Delegate @ Data Source Methods
    //
    func tabBarViewChangedSelectedIndex(at index: Int) {
        selectedIndex = index
    }
    /// Center addButton is pressed, so this func presents the addItemVC modely
    func addItemTabPressed() {
        performSegue(withIdentifier: "toAddItemVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddItemVC" {
            guard let destinationNav = segue.destination as? UINavigationController,
                let destinationVC = destinationNav.viewControllers.first as? AddItemTableViewController else { return }
            if let myStuffVC = UIApplication.topViewController() as? MyStuffViewController {
                destinationVC.tempItem.category = myStuffVC.category
            }
        }
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController

            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }

        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }

        return base
    }
}
