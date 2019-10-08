//
//  ArticleViewModelTests.swift
//  OmniNewsTests
//
//  Created by Kamil Buczel on 08/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Nimble
@testable import OmniNews
import Quick
import RxSwift
import RxTest

class ArticleViewModelTests: QuickSpec {
    override func spec() {
        var viewModel: ArticleViewModel!
        var mockApiClient: ApiClientMock!
        var articleMock: Article!

        var disposeBag = DisposeBag()

        let paragraphOne = ArticleMock.paragraph(for: "test11111")
        let paragraphTwo = ArticleMock.paragraph(for: "test222")
        let paragraphThree = ArticleMock.paragraph(for: "test3333")

        let mainText = ArticleMock.mainText(with: [paragraphOne, paragraphTwo, paragraphThree])

        beforeEach {
            disposeBag = DisposeBag()
            mockApiClient = ApiClientMock()

            articleMock = ArticleMock.article(articleID: "testArticleId", imageId: "testImageId", sourceID: "testSourceId", mainText: mainText, title: "testTitle")

            viewModel = ArticleViewModel(article: articleMock, apiClient: mockApiClient)
        }

        context("getter") {
            it("title should return valid value") {
                expect(viewModel.title) == "testTitle"
            }

            it("details should return valid value") {
                expect(viewModel.details.debugDescription) == "test11111\n\ntest222\n\ntest3333\n\n".debugDescription
            }
        }

        context("image fetch") {
            it("should return error on bad URL") {
                let testScheduler = TestScheduler(initialClock: 0)
                let thumbnailObserver = testScheduler.createObserver(Data.self)

                articleMock = ArticleMock.article(articleID: "testArticleId", imageId: nil, sourceID: "testSourceId", mainText: mainText, title: "testTitle")

                viewModel = ArticleViewModel(article: articleMock, apiClient: mockApiClient)

                viewModel.articleThumbnailSingle.asObservable().bind(to: thumbnailObserver).disposed(by: disposeBag)

                expect(thumbnailObserver.events) == [.error(0, NetworkError.badURL)]
            }
        }
    }
}
