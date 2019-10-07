//
//  ArticlesListViewModel.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ArticlesListViewModel {
    var articlesListSingle: Single<[Article]> {
        return apiClient
            .getArticles()
            .do(onSuccess: { [weak self] items in
                guard let self = self else {
                    return
                }

                self.articlesList = items.map {
                    ArticleViewModel(article: $0, apiClient: self.apiClient)
                }
            })
    }

    var articlesCount: Int {
        return articlesList.count
    }

    private var articlesList: [ArticleViewModel] = []
    private let apiClient: NetworkClient
    private let disposeBag = DisposeBag()

    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }

    func articleViewModel(for index: Int) -> ArticleViewModel? {
        guard articlesList.indices.contains(index) else {
            return nil
        }

        return articlesList[index]
    }
}
