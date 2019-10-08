//
//  ArticlesListViewModelTests.swift
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

extension Article: Equatable {
    public static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.articleID == rhs.articleID
    }
}

class ArticlesListViewModelTests: QuickSpec {
    override func spec() {
        var viewModel: ArticlesListViewModel!
        var mockApiClient: ApiClientMock!

        var articleMock: Article!
        var articleMockTwo: Article!
        var articleMockThree: Article!

        var disposeBag = DisposeBag()

        let paragraphOne = ArticleMock.paragraph(for: "test11111")
        let paragraphTwo = ArticleMock.paragraph(for: "test222")
        let paragraphThree = ArticleMock.paragraph(for: "test3333")

        let mainText = ArticleMock.mainText(with: [paragraphOne, paragraphTwo, paragraphThree])

        beforeEach {
            disposeBag = DisposeBag()
            mockApiClient = ApiClientMock()

            articleMock = ArticleMock.article(
                articleID: "testArticleId", imageId: "testImageId", sourceID: "testSourceId",
                mainText: mainText, title: "testTitle"
            )

            articleMockTwo = ArticleMock.article(
                articleID: "testArticleId2", imageId: "testImageId2", sourceID: "testSourceId2",
                mainText: mainText, title: "testTitle2"
            )

            articleMockThree = ArticleMock.article(
                articleID: "testArticleId3", imageId: "testImageId3", sourceID: "testSourceId3",
                mainText: mainText, title: "testTitle3"
            )

            mockApiClient.articlesToReturn = .just([articleMock, articleMockTwo, articleMockThree])

            viewModel = ArticlesListViewModel(apiClient: mockApiClient)
        }

        describe("data stream") {
            context("articlesListSingle") {
                it("should response with articles") {
                    let testScheduler = TestScheduler(initialClock: 0)
                    let articleObserver = testScheduler.createObserver([Article].self)

                    mockApiClient.articlesToReturn = .just([articleMock, articleMockThree])

                    viewModel.articlesListSingle.asObservable().bind(to: articleObserver).disposed(by: disposeBag)

                    expect(articleObserver.events) == [.next(0, [articleMock, articleMockThree]), .completed(0)]
                }
            }
        }

        describe("getter") {
            beforeEach {
                viewModel.articlesListSingle.subscribe().disposed(by: disposeBag)
            }

            context("articles") {
                it("articlesCount should return valid value") {
                    expect(viewModel.articlesCount) == 3
                }

                it("articleViewModel will return nil for non existing item") {
                    expect(viewModel.articleViewModel(for: 99)).to(beNil())
                }

                it("articleViewModel will return valid view model for fetched item") {
                    expect(viewModel.articleViewModel(for: 2)?.title) == "testTitle3"
                }
            }
        }
    }
}
