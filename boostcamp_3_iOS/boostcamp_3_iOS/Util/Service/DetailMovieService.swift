//
//  DetailMovieService.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 10/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct DetailMovieService: APIServie {
    
    //GET(영화 상세보기) - /movie?id=""
    static func getDetailMovie(id: String, completion: @escaping (DetailMovie) -> Void) {
        
        //url 세팅
        let urlString = url("movie?id=\(id)")
        print(urlString)
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
            do {
                
                let detailMovieData = try JSONDecoder().decode(DetailMovie.self, from: data)
                completion(detailMovieData)
                print(detailMovieData)
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
}

