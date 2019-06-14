//
//  AlbumDTO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation

struct AlbumDTO: Decodable {
    var wrapperType: WrapperType = .unknown
    var collectionName: String = ""
    var image: String = ""
    var releaseDate: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case wrapperType
        case collectionName
        case followers
        case image = "artworkUrl100"
        case releaseDate
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) // defining our (keyed) container
        let wrapperType: String = try container.decode(String.self, forKey: .wrapperType)
        if let wrapperType = WrapperType.init(rawValue: wrapperType) {
            self.wrapperType = wrapperType
        }
        let collectionName = try? container.decode(String.self, forKey: .collectionName)
        if let collectionName = collectionName {
            self.collectionName = collectionName
        }
        let image = try? container.decode(String.self, forKey: .image)
        if let image = image {
            self.image = image
        }
        let releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        if let releaseDate = releaseDate {
            self.releaseDate = releaseDate
        }
    }
}

enum WrapperType: String, Decodable {
    case collection
    
    case unknown
}
