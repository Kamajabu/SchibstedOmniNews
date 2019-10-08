//
//  TopicMock.swift
//  OmniNewsTests
//
//  Created by Kamil Buczel on 08/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

@testable import OmniNews

struct TopicMock {
    static func topic(title: String?, topicId: String?, imageId: String?, sourceID: String?, topicType: TopicType?) -> Topic {
        let imageSize = ImageSize(height: 10, width: 20)
        let imageAsset = ImageAsset(id: imageId, size: imageSize)
        let mainResource = MainResource(imageAsset: imageAsset, sourceID: sourceID)

        return Topic(title: title, topicID: topicId, type: topicType, image: mainResource)
    }
}
