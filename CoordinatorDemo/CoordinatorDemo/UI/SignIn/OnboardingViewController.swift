//
//  OnboardingViewController.swift
//  CoordinatorDemo
//
//  Created by RYAN GREENBURG on 2/24/21.
//

import UIKit

class OnboardingViewController: UIViewController, StoryboardInstantiable {
    var coordinator: NavigationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        coordinator?.resetRootView()
    }
}
