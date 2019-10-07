//
//  MainResource.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

struct MainResource: Codable {
    let imageAsset: ImageAsset?
    let sourceID: String?

    enum CodingKeys: String, CodingKey {
        case imageAsset = "image_asset"
        case sourceID = "source_id"
    }
}
