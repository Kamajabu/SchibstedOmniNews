//
//  Paragraph.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

struct Paragraph: Codable {
    let blockType: BlockType?
    let text: ParagraphText?

    enum CodingKeys: String, CodingKey {
        case blockType
        case text
    }
}
