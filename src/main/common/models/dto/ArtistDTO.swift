//
//  ArtistDTO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import SDOSAlamofire
import SDOSKeyedCodable

struct ArtistDTO: GenericDTO {
    
    mutating func map(map: KeyMap) throws {
        //try identifier <-> map["id"]
    }
    
    init(from decoder: Decoder) throws {
        try KeyedDecoder(with: decoder).decode(to: &self)
    }
}
