//
//  AlbumVO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation

class AlbumVO {
    let itemBO: AlbumBO
    
    var image: String {
        return itemBO.image
    }
    var name: String {
        return itemBO.collectionName
    }
    lazy var date: String? = {
        guard let releaseDate = itemBO.releaseDate else { return nil }
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = "YYYY"
        return dateFormat.string(from: releaseDate)
    }()
    
    public init(with itemBO: AlbumBO) {
        self.itemBO = itemBO
    }
}
