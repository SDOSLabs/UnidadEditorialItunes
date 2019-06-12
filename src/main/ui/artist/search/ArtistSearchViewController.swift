//
//  ArtistSearchViewController.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit
import SDOSLoader


/*
 Dependency register JSON
 
 {
    "dependencyName": "ArtistSearchViewActions",
    "className": "ArtistSearchViewController"
 }
 */

protocol ArtistSearchViewActions: UIViewController, BaseViewActions, ArtistSearchPresenterDelegate {
    
}

class ArtistSearchViewController: BaseViewController {
    private lazy var presenter: ArtistSearchPresenterActions = {
        Dependency.injector.resolveArtistSearchPresenterActions(delegate: self)
    }()
    
    //MARK: - Init
    
    required override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Last line
        self.presenter.viewDidLoad()
    }
    
    //MARK: - Custom methods

}

extension ArtistSearchViewController: ArtistSearchViewActions {
    
}

extension ArtistSearchViewController: ArtistSearchPresenterDelegate {
    func loadUI() {
        
    }
    
    func itemsLoaded(items: [ArtistSearchVO]) {
        //Do stuff
    }
    
    func showError(_ error: Error) {
        
    }
    
    func showCenterLoader() {
        //LoaderManager.showLoader(LoaderManager.loader(withType: LoaderTypeIndeterminateCircular, in: view))
    }
    
    func hideCenterLoader() {
        //LoaderManager.hideLoaders(of: view)
    }
}
