//
//  ApiClientMock.swift
//  OmniNewsTests
//
//  Created by Kamil Buczel on 08/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

@testable import OmniNews
import RxCocoa
import RxSwift

enum ApiMockError: Error {
    case mockMissing
}

class ApiClientMock: NetworkClient {
    var articlesToReturn: Single<[Article]>?
    var topicsToReturn: Single<[Topic]>?

    var imageDataResponse: Single<Data>?
    var urlComponentsMock: URLComponents?

    func getArticles() -> Single<[Article]> {
        guard let response = articlesToReturn else {
            return .error(ApiMockError.mockMissing)
        }

        return response
    }

    func getTopics() -> Single<[Topic]> {
        guard let response = topicsToReturn else {
            return .error(ApiMockError.mockMissing)
        }

        return response
    }

    func getImageData(for _: String) -> Single<Data> {
        guard let response = imageDataResponse else {
            return .error(ApiMockError.mockMissing)
        }

        return response
    }

    var urlComponents: URLComponents {
        return urlComponentsMock ?? URLComponents()
    }
}
