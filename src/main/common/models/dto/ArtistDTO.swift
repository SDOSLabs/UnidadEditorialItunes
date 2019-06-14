//
//  ArtistDTO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation

struct ArtistDTO: Decodable {
    var artistId: Int = 0
    var artistName: String = ""
    var primaryGenreName: String?
    
    private enum CodingKeys: String, CodingKey {
        case artistId
        case artistName
        case primaryGenreName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let artistId = try? container.decode(Int.self, forKey: .artistId)
        if let artistId = artistId {
            self.artistId = artistId
        }
        let artistName = try? container.decode(String.self, forKey: .artistName)
        if let artistName = artistName {
            self.artistName = artistName
        }
        let primaryGenreName = try? container.decode(String.self, forKey: .primaryGenreName)
        if let primaryGenreName = primaryGenreName {
            self.primaryGenreName = primaryGenreName
        }
    }
}
