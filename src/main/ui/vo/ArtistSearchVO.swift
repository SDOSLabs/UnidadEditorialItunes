//
//  ArtistSearchVO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation

class ArtistSearchVO {
    let itemBO: ArtistBO
    
    public init(with itemBO: ArtistBO) {
        self.itemBO = itemBO
    }
}