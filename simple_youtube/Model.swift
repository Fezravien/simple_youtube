//
//  Model.swift
//  simple_youtube
//
//  Created by 윤재웅 on 2020/12/04.
//

import Foundation

class Model {
    func getVideos() {
        
        // URL 객체 생성
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        
        // URLSession 객체
        let session = URLSession.shared
        
        // data task from the URLSession
        let dataTask = session.dataTask(with: url!) { (data, respense, error) in
            
            // error check
            if error != nil || data == nil {
                return
            }
            
            do{
                // parsing the data into video
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                dump(response)
                print("**성공**")
            
            } catch {
                print("**실패**")
                
            }
        }
  
        // 네트워크 시작
        dataTask.resume()
    }
}
