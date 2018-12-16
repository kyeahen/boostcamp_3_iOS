//
//  APIService.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 06/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

protocol APIServie {
    
}

extension APIServie {
    
    static func url(_ path: String) -> String {
        return "http://connect-boxoffice.run.goorm.io/" + path
    }
}

