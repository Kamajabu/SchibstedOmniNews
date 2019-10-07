//
//  Article.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

struct Article: Codable {
    let articleID: String?
    let mainResource: MainResource?
    let mainText: MainText?
    let title: TitleClass?

    enum CodingKeys: String, CodingKey {
        case articleID = "article_id"
        case mainResource = "main_resource"
        case mainText = "main_text"
        case title
    }
}
