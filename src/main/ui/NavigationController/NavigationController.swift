//
//  NavigationController.swift
//  UnidadEditorialItunes
//
//  Created by Rafael Fernandez Alvarez on 13/06/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? .default
    }

}
