//
//  Errors.swift
//  OmniNews
//
//  Created by Kamil Buczel on 07/10/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case mappingError(error: Error)
}

enum DataError: Error {
    case cantParseJSON
}
