//
//  CommentData.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 17/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct CommentData: Codable {
    let movie_id: String
    let comments: [Comment]
}

struct Comment: Codable {
    let timestamp: Double
    let rating: Double
    let movie_id: String
    let writer: String
    let contents: String
    let id: String
}
