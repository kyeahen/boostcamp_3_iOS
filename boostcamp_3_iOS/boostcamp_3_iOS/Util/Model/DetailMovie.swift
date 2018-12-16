//
//  DetailMovie.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 10/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct DetailMovie: Codable {
    
    let audience: Int
    let grade: Int
    let actor: String
    let duration: Int
    let reservation_grade: Int
    let title: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let director: String
    let id: String
    let image: String
    let synopsis: String
    let genre: String

}
