//
//  AlbumDTO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import SDOSAlamofire
import SDOSKeyedCodable

struct AlbumDTO: GenericDTO {
    var wrapperType: WrapperType = .unknown
    var collectionName: String = ""
    var image: String = ""
    var releaseDate: String = ""
    
    mutating func map(map: KeyMap) throws {
        try? wrapperType <<- map["wrapperType"]
        try? collectionName <-> map["collectionName"]
        try? image <-> map["artworkUrl100"]
        try? releaseDate <-> map["releaseDate"]
    }
    
    init(from decoder: Decoder) throws {
        try KeyedDecoder(with: decoder).decode(to: &self)
    }
}

enum WrapperType: String, Decodable {
    case collection
    
    case unknown
}
