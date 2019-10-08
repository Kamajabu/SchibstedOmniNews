//
//  ArticleDetailsCoordinator.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import UIKit

class ArticleDetailsCoordinator: Coordinator {
    private var articlesDetailsViewController: ArticlesDetailsViewController?

    private let presenter: UINavigationController
    private let viewModel: ArticleViewModel

    init(presenter: UINavigationController, article: ArticleViewModel) {
        self.presenter = presenter
        viewModel = article
    }

    func start() {
        let articlesDetailsViewController = ArticlesDetailsViewController(viewModel: viewModel)
        presenter.pushViewController(articlesDetailsViewController, animated: true)

        self.articlesDetailsViewController = articlesDetailsViewController
    }
}
