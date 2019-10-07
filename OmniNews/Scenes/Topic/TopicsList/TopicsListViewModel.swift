//
//  TopicsListViewModel.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TopicsListViewModel {
    var topicsListSingle: Single<[Topic]> {
        return apiClient
            .getTopics()
            .do(onSuccess: { [weak self] items in
                guard let self = self else {
                    return
                }

                self.topicsList = items
            })
    }

    var topicsCount: Int {
        return topicsList.count
    }

    private var topicsList: [Topic] = []

    private let apiClient: NetworkClient
    private let disposeBag = DisposeBag()

    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }

    func topic(for index: Int) -> Topic? {
        guard topicsList.indices.contains(index) else {
            return nil
        }

        return topicsList[index]
    }

    func topicTitle(for index: Int) -> String {
        return topic(for: index)?.title ?? "-"
    }
}
