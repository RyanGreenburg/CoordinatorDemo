//
//  SignInViewController.swift
//  CoordinatorDemo
//
//  Created by RYAN GREENBURG on 2/24/21.
//

import UIKit

class SignInViewController: UIViewController, StoryboardInstantiable {
    var coordinator: NavigationCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        coordinator?.goTo(OnboardingViewController.self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
