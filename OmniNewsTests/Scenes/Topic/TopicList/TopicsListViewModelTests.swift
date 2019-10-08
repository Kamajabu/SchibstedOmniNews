//
//  TopicsListViewModelTests.swift
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

extension Topic: Equatable {
    public static func == (lhs: Topic, rhs: Topic) -> Bool {
        return lhs.topicID == rhs.topicID
    }
}

class TopicsListViewModelTests: QuickSpec {
    override func spec() {
        var viewModel: TopicsListViewModel!
        var mockApiClient: ApiClientMock!

        var topicMock: Topic!
        var topicMockTwo: Topic!
        var topicMockThree: Topic!

        var disposeBag = DisposeBag()

        beforeEach {
            disposeBag = DisposeBag()
            mockApiClient = ApiClientMock()

            topicMock = TopicMock.topic(
                title: "testTitle1", topicId: "testTopicId1", imageId: "testImageId1",
                sourceID: "testSourceId1", topicType: .descriptor
            )

            topicMockTwo = TopicMock.topic(
                title: "testTitle2", topicId: "testTopicId2", imageId: "testImageId2",
                sourceID: "testSourceId2", topicType: .location
            )

            topicMockThree = TopicMock.topic(
                title: "testTitle3", topicId: "testTopicId3", imageId: "testImageId3",
                sourceID: "testSourceId3", topicType: .organization
            )

            mockApiClient.topicsToReturn = .just([topicMock, topicMockTwo, topicMockThree])

            viewModel = TopicsListViewModel(apiClient: mockApiClient)
        }

        describe("data stream") {
            context("topicsListSingle") {
                it("should response with topics") {
                    let testScheduler = TestScheduler(initialClock: 0)
                    let topicObserver = testScheduler.createObserver([Topic].self)

                    mockApiClient.topicsToReturn = .just([topicMockTwo, topicMockThree])

                    viewModel.topicsListSingle.asObservable().bind(to: topicObserver).disposed(by: disposeBag)

                    expect(topicObserver.events) == [.next(0, [topicMockTwo, topicMockThree]), .completed(0)]
                }
            }
        }

        describe("getter") {
            beforeEach {
                viewModel.topicsListSingle.subscribe().disposed(by: disposeBag)
            }

            context("articles") {
                it("topicsCount should return valid value") {
                    expect(viewModel.topicsCount) == 3
                }

                it("topic will return nil for non existing item") {
                    expect(viewModel.topic(for: 99)).to(beNil())
                }

                it("topic title will return dash for non existing item") {
                    expect(viewModel.topicTitle(for: 99)) == "-"
                }

                it("topic will return valid topic for fetched item") {
                    expect(viewModel.topic(for: 2)) == topicMockThree
                }

                it("topic title will return valid value") {
                    expect(viewModel.topicTitle(for: 1)) == "testTitle2"
                }
            }
        }
    }
}
