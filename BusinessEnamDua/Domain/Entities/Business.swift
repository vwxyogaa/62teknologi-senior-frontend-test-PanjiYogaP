//
//  Business.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

struct Business: Codable {
    let businesses: [BusinessElement]?
    let total: Int?
    let region: Region?
    
    struct BusinessElement: Codable {
        let id, alias, name: String?
        let imageURL: String?
        let isClosed: Bool?
        let url: String?
        let reviewCount: Int?
        let categories: [Category]?
        let rating: Double?
        let coordinates: Center?
        let transactions: [Transaction]?
        let price: String?
        let location: Location?
        let phone, displayPhone: String?
        let distance: Double?
        let photos: [String]?
        
        enum CodingKeys: String, CodingKey {
            case id, alias, name
            case imageURL = "image_url"
            case isClosed = "is_closed"
            case url
            case reviewCount = "review_count"
            case categories, rating, coordinates, transactions, price, location, phone
            case displayPhone = "display_phone"
            case distance
            case photos
        }
        
        struct Category: Codable {
            let alias, title: String?
        }
        
        struct Location: Codable {
            let address1: String?
            let address2: String?
            let address3: String?
            let city: String?
            let zipCode: String?
            let country: String?
            let state: String?
            let displayAddress: [String]?
            
            enum CodingKeys: String, CodingKey {
                case address1, address2, address3, city
                case zipCode = "zip_code"
                case country, state
                case displayAddress = "display_address"
            }
        }
        
        enum Transaction: String, Codable {
            case delivery = "delivery"
            case pickup = "pickup"
            case restaurantReservation = "restaurant_reservation"
        }
        
        var imageUrlImage: String? {
            get {
                guard let imageURL else { return "" }
                return imageURL
            }
        }
    }
    
    struct Region: Codable {
        let center: Center?
    }
    
    struct Center: Codable {
        let latitude, longitude: Double?
    }
}
