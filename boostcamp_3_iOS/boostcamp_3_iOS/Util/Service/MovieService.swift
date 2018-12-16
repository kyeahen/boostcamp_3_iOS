//
//  MovieService.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 06/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit

struct MovieService: APIServie {
    
    //GET(영화 목록) - /movies?order_type=0 (0: 예매율(default) 1: 큐레이션 2: 개봉일)
    static func getMovieList(orderType: Int, completion: @escaping ([Movie]) -> Void) {
        
        //url 세팅
        let urlString = url("/movies?order_type=\(orderType)")
        //url에 한글있는 경우 인코딩을 바꿔주어야한다!
        guard let url = URL(string:urlString.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!) else {
            print("URL is nil")
            return
        }
        
        //request보낼 url를 지정 및 request설정
        var request = URLRequest(url: url)
        //request http방식을 지정 지정않하면 get 방식
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            
            do {
                let movieData = try JSONDecoder().decode(MovieData.self, from: data)
                completion(movieData.movies)
                print(movieData.movies)

                
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
}
