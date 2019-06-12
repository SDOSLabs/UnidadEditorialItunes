//
//  AlbumMapper.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit

extension AlbumDTO {
    func toBO() -> AlbumBO? {
    return AlbumBO(dto: self)
    }
}

extension AlbumBO {
    init?(dto item: AlbumDTO) {
        switch item.wrapperType {
        case .collection:
            collectionName = item.collectionName
            image = item.image
            releaseDate = item.releaseDate
        default:
            return nil
        }
    }
}
