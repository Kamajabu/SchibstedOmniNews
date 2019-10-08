//
//  ApiClient.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Firebase
import Foundation
import RxFirebase
import RxSwift

protocol NetworkClient: class {
    func getArticles() -> Single<[Article]>
    func getTopics() -> Single<[Topic]>

    func getImageData(for assetId: String) -> Single<Data>
}

final class ApiClient: NetworkClient {
    let ref = Database.database().reference()

    func getArticles() -> Single<[Article]> {
        ref.child(NetworkKeys.articles)
            .rx
            .observeSingleEvent(.value)
            .map { [weak self] snapshot -> [Article] in
                guard let value = snapshot.value,
                    let data = self?.jsonToData(json: value) else {
                    return []
                }
                return try JSONDecoder().decode([Article].self, from: data)
            }
    }

    func getTopics() -> Single<[Topic]> {
        ref.child(NetworkKeys.topics)
            .rx
            .observeSingleEvent(.value)
            .map { [weak self]  snapshot -> [Topic] in
                guard let value = snapshot.value,
                    let data = self?.jsonToData(json: value) else {
                    return []
                }
                return try JSONDecoder().decode([Topic].self, from: data)
            }
    }

    func getImageData(for assetId: String) -> Single<Data> {
        var urlComponent = urlComponents
        urlComponent.path = "\(NetworkKeys.images)/\(assetId)"

        return fetchData(from: urlComponent.url)
    }

    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = NetworkKeys.baseUrl
        return urlComponents
    }

    private func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }

    private func fetchData(from url: URL?) -> Single<Data> {
        return Single<Data>.create { single in

            guard let url = url else {
                single(.error(NetworkError.badURL))
                return Disposables.create()
            }

            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    single(.error(error))
                    return
                }

                guard let data = data else {
                    return single(.error(NetworkError.noData))
                }

                single(.success(data))
            }

            task.resume()

            return Disposables.create { task.cancel() }
        }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}
