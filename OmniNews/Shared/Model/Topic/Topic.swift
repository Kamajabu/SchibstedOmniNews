//
//  Topic.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

struct Topic: Codable {
    let title: String?
    let topicID: String?
    let type: TopicType?
    let image: MainResource?

    enum CodingKeys: String, CodingKey {
        case title
        case topicID
        case type
        case image
    }
}
