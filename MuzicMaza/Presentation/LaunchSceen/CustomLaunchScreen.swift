//
//  ViewController.swift
//  MuzicMaza
//
//  Created by Suvendu Kumar on 04/04/24.
//

import UIKit

class CustomLaunchScreen: UIViewController {
    
    @IBOutlet weak var launchImageBack: UIImageView!
    @IBOutlet weak var launchImageFront: UIImageView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateBackGround()
        animate()
    }
    
    private func animateBackGround() {
        UIView.animate(withDuration: 1, delay: 0) { [weak self] in guard let self else { return }
            launchImageFront.alpha = 0.1
            launchImageFront.transform = CGAffineTransform(scaleX: 8, y: 8)
            
        }
    }
    
    private func animate() {
        UIView.animate(withDuration: 1, delay: 0.6) { [weak self] in guard let self else { return }
            launchImageBack.transform = CGAffineTransform(scaleX: 2.2, y: 2.2)
        } completion:{ [weak self] _ in guard let self else { return }
            navigateToHomeView()
        }
    }
    
    private func navigateToHomeView() {
        let controllerMain = UIStoryboard(name: "HomeViewController", bundle: nil)
        let sBordMain = controllerMain.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let navigation = UINavigationController(rootViewController: sBordMain)
        UIApplication.shared.windows.first?.rootViewController = navigation
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
