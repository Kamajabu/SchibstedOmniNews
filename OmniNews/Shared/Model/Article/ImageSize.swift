//
//  ImageSize.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

struct ImageSize: Codable {
    let height: Int?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case height
        case width
    }
}
