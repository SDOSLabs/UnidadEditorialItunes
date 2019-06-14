//
//  AlbumDetailVO.swift
//
//  Created by Rafael Fernandez Alvarez on 14/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation

class AlbumDetailVO {
    let albumsBO: [AlbumBO]?
    let artistBO: ArtistBO
    
    lazy var artistVO = {
        return ArtistSearchVO(with: artistBO)
    }()
    
    lazy var content: [AlbumDetailType] = {
       var result = [AlbumDetailType]()
        result.append(.artist(artist: artistVO))
        albumsBO?.forEach {
            result.append(.album(album: AlbumVO(with: $0)))
        }
        return result
    }()
    
    public init(with albumsBO: [AlbumBO]?, artistBO: ArtistBO) {
        self.albumsBO = albumsBO
        self.artistBO = artistBO
    }
}

enum AlbumDetailType {
    case artist(artist: ArtistSearchVO)
    case album(album: AlbumVO)
}
