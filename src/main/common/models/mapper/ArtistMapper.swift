//
//  ArtistMapper.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit

extension ArtistDTO {
    func toBO() -> ArtistBO {
    return ArtistBO(dto: self)
    }
}

extension ArtistBO {
     init(dto item: ArtistDTO) {
        artistId = item.artistId
        artistName = item.artistName
        primaryGenreName = item.primaryGenreName
    }
}
