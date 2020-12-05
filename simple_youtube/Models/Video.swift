//
//  Video.swift
//  simple_youtube
//
//  Created by 윤재웅 on 2020/12/04.
//

import Foundation

struct Video: Decodable {
    
    // youtube json data struct
    /*
     items [
        snippet {
            published
            title
            description
            thumbnail {
                 default ...
                 medium ...
                 high {
                     url
                     width
                     height
                    }
                 standard ...
    
            }
        }
     ]
     */
    
    // json 데이터에서 우리가 원하는 데이터 항목
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    // 정해 놓은 변수와 json 변수가 다르면 할당해준다.
    enum CodingKeys: String, CodingKey {
        
        // joson 구조 형식으로 만듬
        case snippet
            case published = "publishedAt"
            case title
            case description
            case thumbnails
                case high
                    case thumbnail = "url"
            case resourceId
                case videoId
         
    }
    
    init(from decoder: Decoder) throws {
        
        // items
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // snippet
        // nestedContainer -- 하위 항목으로
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
    
        // Parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // Parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // Parse the pulish date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        // Parse thumbnails
        // thumbnails 하위 항목이 필요 - high
        let thumnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)

        // high 하위 항목 필요 - url, width, height
        let highContainer = try thumnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // Parse Video ID
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
        
        
    }
}

