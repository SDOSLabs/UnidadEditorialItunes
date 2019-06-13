//
//  ArtistSearchVO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation

class ArtistSearchVO {
    let itemBO: ArtistBO
    
    var name: String {
        return itemBO.artistName
    }
    
    var genre: String? {
        return itemBO.primaryGenreName
    }
    
    var albums: [AlbumVO]? = nil
    
    public init(with itemBO: ArtistBO) {
        self.itemBO = itemBO
    }
}

extension ArtistSearchVO: Equatable {
    static func == (lhs: ArtistSearchVO, rhs: ArtistSearchVO) -> Bool {
        if lhs.itemBO.artistId == rhs.itemBO.artistId {
            return true
        }
        return false
    }
    
    
}
