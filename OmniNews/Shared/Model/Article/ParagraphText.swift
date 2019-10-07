//
//  ParagraphText.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

struct ParagraphText: Codable {
    let value: String?

    enum CodingKeys: String, CodingKey {
        case value
    }
}
