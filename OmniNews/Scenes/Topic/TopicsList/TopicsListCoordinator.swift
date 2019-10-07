//
//  TopicsListCoordinator.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import UIKit

class TopicsListCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return navigationController
    }

    private var topicsListViewController: TopicsListViewController?
    private var topicDetailsCoordinator: TopicDetailsCoordinator?
    private var navigationController: UINavigationController

    private let mainStore: MainStore

    init(mainStore: MainStore) {
        self.mainStore = mainStore

        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.view.backgroundColor = .white
    }

    func start() {
        let topicsListViewModel = TopicsListViewModel(apiClient: mainStore.apiClient)
        let topicsListViewController = TopicsListViewController(viewModel: topicsListViewModel, delegate: self)
        topicsListViewController.title = "Topics"

        navigationController.pushViewController(topicsListViewController, animated: true)

        self.topicsListViewController = topicsListViewController
    }
}

extension TopicsListCoordinator: TopicsListViewControllerDelegate {
    func didSelectTopic(_ selectedTopic: Topic) {
        let topicDetailsCoordinator = TopicDetailsCoordinator(presenter: navigationController, topic: selectedTopic)

        topicDetailsCoordinator.start()

        self.topicDetailsCoordinator = topicDetailsCoordinator
    }
}
