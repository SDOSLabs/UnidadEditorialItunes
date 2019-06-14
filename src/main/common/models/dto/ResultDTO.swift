//
//  ResultDTO.swift
//  UnidadEditorialItunes
//
//  Created by Rafael Fernandez Alvarez on 13/06/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation


struct ResultDTO<Type: Decodable>: Decodable {
    var results: [Type] = [Type]()
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let results = try? container.decode([Type].self, forKey: .results)
        if let results = results {
            self.results = results
        }
    }
}
