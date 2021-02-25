//
//  Coordinator.swift
//  CoordinatorDemo
//
//  Created by RYAN GREENBURG on 2/24/21.
//

import UIKit
var hasUser: Bool = false

final class AppCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if !hasUser {
            let coordinator = NavigationCoordinator(appCoordinator: self)
            coordinator.start(with: SignInViewController.self)
            window.rootViewController = coordinator.navigationController
            window.makeKeyAndVisible()
        } else {
            let coordinator = TabBarCoordinator(appCoordinator: self)
            coordinator.start()
            window.rootViewController = coordinator.tabBarController
            window.makeKeyAndVisible()
        }
    }
}

class Coordinator {
    private let appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func resetRootView() {
        appCoordinator.start()
    }
}

final class TabBarCoordinator: Coordinator {
    let tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController = UITabBarController(),
         appCoordinator: AppCoordinator) {
        
        self.tabBarController = tabBarController
        super.init(appCoordinator: appCoordinator)
    }
    
    func start(with viewControllers: [UIViewController] = []) {
        tabBarController.viewControllers = viewControllers
    }
}


final class NavigationCoordinator: Coordinator {
    // MARK: - Properties

    let navigationController: UINavigationController

    // MARK: - Initial Views

    /// Initialize the coordinator
    /// - Parameter navigationController: A navigation controller that the coordinator will use for most of its operations
    init(navigationController: UINavigationController = UINavigationController(),
         appCoordinator: AppCoordinator) {
        
        self.navigationController = navigationController
        super.init(appCoordinator: appCoordinator)
    }

    /// Start the coordinator by going to the initial view
    func start<T: StoryboardInstantiable>(with startingVC: T.Type) {
        goTo(startingVC)
    }

    // MARK: - Navigating Back

    /// Go back to whatever the previous view on the stack is
    func goBack() {
        navigationController.popViewController(animated: true)
    }

    /// Go back to the initial view controller that the coordinator was started with
    func goBackToInitialViewController() {
        navigationController.popToRootViewController(animated: true)
    }

    // MARK: - Generics to Show Any View

    /// Show a view modally (ie, sliding up to cover the screen)
    /// - Parameters:
    ///   - viewToPresent: The view that you want to present, which has a coordinator object that you want to use
    ///   - presentingVC: The parent view (ie, self) from which to present the modal view
    ///   - extraSteps: A completion to handle any extra steps needed to initialize the new view (ie,  passing information, setting variables, etc)
    func showModally<T: StoryboardInstantiable>(_ viewToPresent: T.Type,
                                                from presentingVC: UIViewController,
                                                style: UIModalPresentationStyle = .overCurrentContext,
                                                animated: Bool = true,
                                                completion: ((UIViewController) -> Void)? = nil) {
        
        guard let viewController = viewToPresent.instantiate() as? StoryboardInstantiable else { return }
        viewController.coordinator = self
        viewController.modalPresentationStyle = .overCurrentContext
        completion?(viewController)
        presentingVC.present(viewController, animated: animated)
    }

    /// Transition to the next view sideways, as with a navigation controller
    /// - Parameters:
    ///   - viewToShow: The view that you want to transition to, which must have a coordinator object
    ///   - extraSteps: A completion to handle any extra steps needed to initialize the new view (ie,  passing information, setting variables, etc)
    func goTo<T: StoryboardInstantiable>(_ viewToShow: T.Type,
                                         completion: ((UIViewController) -> Void)? = nil) {
        
        guard let viewController = viewToShow.instantiate() as? StoryboardInstantiable else { return }
        viewController.coordinator = self
        completion?(viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}

