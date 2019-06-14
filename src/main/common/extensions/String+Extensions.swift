//
//  String+Extensions.swift
//  UnidadEditorialItunes
//
//  Created by Rafael Fernandez Alvarez on 14/06/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation

extension String {
    func urlEncodeApi() -> String {
        return self.trimmed.urlEncoded.replacingOccurrences(of: "%20", with: "+")
    }
}
