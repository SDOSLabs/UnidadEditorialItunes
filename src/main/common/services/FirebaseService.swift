//
//  FirebaseService.swift
//  UnidadEditorialItunes
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSPluggableApplicationDelegate
import SDOSFirebase
import SDOSEnvironment

class FirebaseService: NSObject, ApplicationService {
    static let shared = FirebaseService()
    private override init() { }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        SDOSFirebase.configure(options: SDOSFirebase.options(environment: SDOSEnvironment.environmentKey))
        return true
    }
}
