//
//  AppDelegate.swift
//  UnidadEditorialItunes
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import UIKit
import SDOSPluggableApplicationDelegate

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
    
    override var services: [ApplicationService] {
        return [
            EnviromentService.shared, //MUST BE FIRST
            FLEXService.shared,
            KeyboardService.shared,
            UserInterfaceService.shared
        ]
    }
}

