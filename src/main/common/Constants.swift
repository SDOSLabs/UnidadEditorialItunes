//
//  Constants.swift
//  UnidadEditorialItunes
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation

struct Constants {
    struct ws {
        static let search = "/search"
        static let lookup = "/lookup"
        
        struct paramKey {
            static let term = "term"
            static let id = "id"
            static let entity = "entity"
            static let attribute = "attribute"
            static let sort = "sort"
            static let media = "music"
            
        }
        
        struct paramValue {
            static let entityAlbum = "album"
            static let attributeAlbum = "albumTerm"
            static let sortRecent = "recent"
            static let entityArtist = "allArtist"
            static let attributeArtist = "allArtistTerm"
            static let media = "music"
        }
    }
    
    struct date {
        static let formatAlbum = "YYYY-MM-DD'T'HH:mm:ss'Z'"
    }
}

enum WSError: Error {
    case noConnection
    case noUrl
    case incorrectHTTPStatusCode
    case noContent
}
