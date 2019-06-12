//
//  FabricService.swift
//  UnidadEditorialItunes
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSPluggableApplicationDelegate
import Fabric
import Crashlytics

class FabricService: NSObject, ApplicationService {
    static let shared = FabricService()
    private override init() { }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Fabric.with([Crashlytics.self])
        return true
    }
}
