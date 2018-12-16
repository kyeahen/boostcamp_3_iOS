//
//  MovieData.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 06/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct MovieData: Codable {
    let order_type: Int
    let movies: [Movie]
}

struct Movie: Codable {
    let date: String
    let reservation_grade: Int
    let user_rating: Double
    let id: String
    let grade: Int
    let title: String
    let thumb: String
    let reservation_rate: Double
}
