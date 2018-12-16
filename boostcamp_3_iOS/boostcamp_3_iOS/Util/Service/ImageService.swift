//
//  ImageService.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 07/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit

struct ImageService {
    
   static func getImageUpload(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        
        let url = URL(string: imageUrl)!
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error == nil {
                let image = UIImage(data: data!)
                
                completion(image)
            }
        }
        task.resume()
    }
}
