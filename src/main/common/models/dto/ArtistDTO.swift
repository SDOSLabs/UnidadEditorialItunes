//
//  ArtistDTO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import SDOSAlamofire
import SDOSKeyedCodable

struct ArtistDTO: GenericDTO {
    var artistId: Int = 0
    var artistName: String = ""
    var primaryGenreName: String?
    
    mutating func map(map: KeyMap) throws {
        try artistId <-> map["artistId"]
        try artistName <-> map["artistName"]
        try primaryGenreName <-> map["primaryGenreName"]
    }
    
    init(from decoder: Decoder) throws {
        try KeyedDecoder(with: decoder).decode(to: &self)
    }
}
