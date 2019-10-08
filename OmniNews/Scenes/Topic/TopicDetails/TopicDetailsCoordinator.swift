//
//  TopicDetailsCoordinator.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import UIKit

class TopicDetailsCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var topicDetailsViewController: TopicDetailsViewController?
    private let model: Topic

    init(presenter: UINavigationController, topic: Topic) {
        self.presenter = presenter
        self.model = topic
    }

    func start() {
        let topicDetailsViewController = TopicDetailsViewController(model: model)
        presenter.pushViewController(topicDetailsViewController, animated: true)

        self.topicDetailsViewController = topicDetailsViewController
    }
}
