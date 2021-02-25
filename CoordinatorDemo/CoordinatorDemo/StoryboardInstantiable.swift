//
//  StoryboardInstantiable.swift
//  CoordinatorDemo
//
//  Created by RYAN GREENBURG on 2/24/21.
//

import UIKit

protocol StoryboardInstantiable where Self: UIViewController {
    var coordinator: NavigationCoordinator? { get set }
    static func instantiate() -> UIViewController
    static func instantiate(fromStoryboard storyboard: String) -> UIViewController
}

extension StoryboardInstantiable {
    static func instantiate() -> UIViewController {
        let fullName = NSStringFromClass(self)

        let className = fullName.components(separatedBy: ".")[1]

        let storyboard = UIStoryboard(name: className, bundle: Bundle.main)

        return storyboard.instantiateInitialViewController() as! Self
    }
    
    static func instantiate(fromStoryboard storyboard: String) -> UIViewController {
        let fullName = NSStringFromClass(self)

        let className = fullName.components(separatedBy: ".")[1]
        
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
