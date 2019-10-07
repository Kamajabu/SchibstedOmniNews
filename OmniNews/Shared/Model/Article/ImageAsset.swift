//
//  ImageAsset.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

struct ImageAsset: Codable {
    let id: String?
    let size: ImageSize?

    enum CodingKeys: String, CodingKey {
        case id
        case size
    }
}
