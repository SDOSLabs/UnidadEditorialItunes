//
//  AlbumVO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation

class AlbumVO {
    let itemBO: AlbumBO
    
    public init(with itemBO: AlbumBO) {
        self.itemBO = itemBO
    }
}
