//
//  VIPERBaseClass.swift
//  UnidadEditorialItunes
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSVIPER
import SDOSFirebase

@objc class BaseRepository: VIPERGenericObject {
    
}

@objc class BaseInteractor : VIPERGenericObject {
    
}

@objc class BasePresenter : VIPERGenericObject {
    
}

@objc class BaseViewController : VIPERGenericViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setFirebaseScreenName(name: firebaseScreenName())
    }
}

@objc class BaseWireframe: VIPERGenericObject {
    
}
