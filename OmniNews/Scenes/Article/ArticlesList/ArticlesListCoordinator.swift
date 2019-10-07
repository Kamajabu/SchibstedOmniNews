//
//  ArticlesListCoordinator.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import UIKit

class ArticlesListCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return navigationController
    }

    private var articlesListViewController: ArticlesListViewController?
    private var articleDetailsCoordinator: ArticleDetailsCoordinator?
    private var navigationController: UINavigationController

    private let mainStore: MainStore

    init(mainStore: MainStore) {
        self.mainStore = mainStore

        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.view.backgroundColor = .white
    }

    func start() {
        let articlesViewModel = ArticlesListViewModel(apiClient: mainStore.apiClient)
        let articlesListViewController = ArticlesListViewController(viewModel: articlesViewModel, delegate: self)
        articlesListViewController.title = "Articles"

        navigationController.pushViewController(articlesListViewController, animated: true)

        self.articlesListViewController = articlesListViewController
    }
}

extension ArticlesListCoordinator: ArticlesListViewControllerDelegate {
    func didSelectArticle(_ selectedArticle: ArticleViewModel) {
        let articleDetailsCoordinator = ArticleDetailsCoordinator(presenter: navigationController,
                                                                  article: selectedArticle)
        articleDetailsCoordinator.start()

        self.articleDetailsCoordinator = articleDetailsCoordinator
    }
}
