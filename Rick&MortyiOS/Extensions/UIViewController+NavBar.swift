//
//  UIViewController+NavBar.swift
//  AevaPay-iOS
//
//  Created by Ibrahim El-geddawy on 17/02/2021.
//

import UIKit

extension UIViewController {
    
    func setupTransparentNavigationBar() {
        let appearance = UINavigationBarAppearance()
           appearance.configureWithTransparentBackground()
           appearance.backgroundColor = .clear
           appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
           
           navigationController?.navigationBar.standardAppearance = appearance
           navigationController?.navigationBar.scrollEdgeAppearance = appearance
           navigationController?.navigationBar.prefersLargeTitles = false
    }
    func setupEnlargedNavigation(title: String) {
        if let navigationController = self.navigationController {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
            navigationController.navigationBar.prefersLargeTitles = true
        }
        
        self.title = title
    }
    
    func addBackButton() {
        let back = UIImage(named: "back")
        setupTransparentNavigationBar()
        navigationController?.navigationBar.backIndicatorImage = back
        
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = back
    }
    
    func showAlert(title: String, message: String, okTitle: String = "Ok", okHandler: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: okHandler))
        self.present(alert, animated: true, completion: nil)
    }
                                                    
}
