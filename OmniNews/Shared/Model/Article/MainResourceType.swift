//
//  MainResourceType.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

enum MainResourceType: String, Codable {
    case byline = "Byline"
    case carousel = "Carousel"
    case image = "Image"
    case storyVignette = "StoryVignette"
    case subheading = "Subheading"
    case text = "Text"
    case title = "Title"
    case url = "Url"
    case webview = "Webview"
}
