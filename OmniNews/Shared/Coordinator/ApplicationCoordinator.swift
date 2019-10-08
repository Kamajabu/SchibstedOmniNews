//
//  ApplicationCoordinator.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    var rootViewController: UIViewController {
        return tabController
    }

    private var coordinators: [Coordinator] {
        return [articlesCoordinator]
    }

    private let window: UIWindow
    private let tabController: UITabBarController

    private let articlesCoordinator: ArticlesListCoordinator
    private let topicsCoordinator: TopicsListCoordinator

    private let mainStore: MainStore = MainStore()

    init(window: UIWindow) {
        self.window = window
        self.tabController = UITabBarController()

        self.articlesCoordinator = ArticlesListCoordinator(mainStore: mainStore)
        self.articlesCoordinator.start()

        self.topicsCoordinator = TopicsListCoordinator(mainStore: mainStore)
        self.topicsCoordinator.start()

        var controllers: [UIViewController] = []

        let articlesViewController = articlesCoordinator.rootViewController
        let topicsListViewController = topicsCoordinator.rootViewController

        articlesViewController.tabBarItem = UITabBarItem(title: "Articles",
                                                         image: UIImage(named: SharedImages.articlesMenuOff),
                                                         selectedImage: UIImage(named: SharedImages.articlesMenuOn))

        topicsListViewController.tabBarItem = UITabBarItem(title: "Topics",
                                                           image: UIImage(named: SharedImages.topicsMenuOff),
                                                           selectedImage: UIImage(named: SharedImages.topicsMenuOn))

        super.init()

        controllers.append(articlesViewController)
        controllers.append(topicsListViewController)

        tabController.viewControllers = controllers
        tabController.tabBar.isTranslucent = false
        tabController.delegate = self
    }

    func start() {
        window.rootViewController = tabController
        window.makeKeyAndVisible()
    }
}
