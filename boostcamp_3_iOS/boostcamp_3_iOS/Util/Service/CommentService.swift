//
//  CommentService.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 17/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct CommentService: APIServie {
    
    //GET(영화 한줄평) - /comments?movie_id=""
    static func getCommentList(id: String, completion: @escaping ([Comment]) -> Void) {
        
        //url 세팅
        let urlString = url("comments?movie_id=\(id)")
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
                
                let commentData = try JSONDecoder().decode(CommentData.self, from: data)
                completion(commentData.comments)
                print(commentData.comments)
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
}
