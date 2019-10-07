//
//  ArticleViewModel.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ArticleViewModel {
    var articleThumbnailSingle: Single<Data> {
        guard let thumbnailAddress = article.mainResource?.imageAsset?.id else {
            return .error(NetworkError.badURL)
        }

        return apiClient
            .getImageData(for: thumbnailAddress)
    }

    var title: String {
        return article.title?.value ?? "-"
    }

    var details: String {
        return article.mainText?.paragraphs?
            .compactMap { $0.text?.value }
            .reduce("") { (result, paragraph) -> String in
                result + paragraph + "\n\n"
            } ?? "-"
    }

    private let article: Article
    private unowned let apiClient: NetworkClient

    init(article: Article, apiClient: NetworkClient) {
        self.article = article
        self.apiClient = apiClient
    }
}
