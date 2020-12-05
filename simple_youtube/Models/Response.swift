//
//  Response.swift
//  simple_youtube
//
//  Created by 윤재웅 on 2020/12/04.
//

import Foundation

struct Response: Decodable {
    
    var items: [Video]?
    
    enum Codingkeys:String, CodingKey {
        
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.items = try container.decode([Video].self, forKey: .items)
    }
    
}
