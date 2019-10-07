//
//  NewsData.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

struct NewsData: Codable {
    let articles: [Article]?
    let topics: [Topic]?

    enum CodingKeys: String, CodingKey {
        case articles
        case topics
    }
}
