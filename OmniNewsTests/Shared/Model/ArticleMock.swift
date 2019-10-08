//
//  ArticleMock.swift
//  OmniNewsTests
//
//  Created by Kamil Buczel on 08/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

@testable import OmniNews

struct ArticleMock {
    static func paragraph(for text: String?) -> Paragraph {
        let blockType = BlockType(rawValue: "testBlockType")
        let text = ParagraphText(value: text)
        return Paragraph(blockType: blockType, text: text)
    }

    static func mainText(with paragraphs: [Paragraph]) -> MainText {
        let mainResourceType = MainResourceType(rawValue: "testType")
        let vignette = Vignette(title: "testTitle")

        return MainText(paragraphs: paragraphs, type: mainResourceType, vignette: vignette)
    }

    static func article(articleID: String?, imageId: String?, sourceID: String?, mainText: MainText?, title: String?) -> Article {
        let imageSize = ImageSize(height: 10, width: 20)
        let imageAsset = ImageAsset(id: imageId, size: imageSize)
        let mainResource = MainResource(imageAsset: imageAsset, sourceID: sourceID)

        let titleClass = TitleClass(value: title)

        return Article(articleID: articleID, mainResource: mainResource, mainText: mainText, title: titleClass)
    }
}
