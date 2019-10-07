//
//  MainText.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

struct MainText: Codable {
    let paragraphs: [Paragraph]?
    let type: MainResourceType?
    let vignette: Vignette?

    enum CodingKeys: String, CodingKey {
        case paragraphs
        case type
        case vignette
    }
}
