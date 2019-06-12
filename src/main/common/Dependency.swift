//
//  Dependency.swift
//  UnidadEditorialItunes
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import Swinject

struct Dependency {
    private init() { }
    
    static let injector: Container = {
        let container = Container()
        container.registerAll()
        return container
    }()
}
