//
//  Reviews.swift
//  BusinessEnamDua
//
//  Created by yxgg on 21/05/23.
//

struct Reviews: Codable {
    let reviews: [Review]?
    let total: Int?
    let possibleLanguages: [String]?
    
    enum CodingKeys: String, CodingKey {
        case reviews, total
        case possibleLanguages = "possible_languages"
    }
    
    struct Review: Codable {
        let id: String?
        let url: String?
        let text: String?
        let rating: Int?
        let timeCreated: String?
        let user: User?
        
        enum CodingKeys: String, CodingKey {
            case id, url, text, rating
            case timeCreated = "time_created"
            case user
        }
        
        struct User: Codable {
            let id: String?
            let profileURL: String?
            let imageURL: String?
            let name: String?
            
            enum CodingKeys: String, CodingKey {
                case id
                case profileURL = "profile_url"
                case imageURL = "image_url"
                case name
            }
        }
    }
}
