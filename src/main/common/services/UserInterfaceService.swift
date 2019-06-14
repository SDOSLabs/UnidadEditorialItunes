//
//  UserInterfaceService.swift
//  UnidadEditorialItunes
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSPluggableApplicationDelegate

class UserInterfaceService: NSObject, ApplicationService {
    static let shared = UserInterfaceService()
    private override init() { }
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = Dependency.injector.resolveNavigationController(rootViewController: Dependency.injector.resolveArtistSearchViewActions())
    
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}
