//
//  ArtistAlbumsViewController.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit
import SDOSLoader


/*
 Dependency register JSON
 
 {
    "dependencyName": "ArtistAlbumsViewActions",
    "className": "ArtistAlbumsViewController"
 }
 */

protocol ArtistAlbumsViewActions: UIViewController, BaseViewActions, ArtistAlbumsPresenterDelegate {
    
}

class ArtistAlbumsViewController: BaseViewController {
    private lazy var presenter: ArtistAlbumsPresenterActions = {
        Dependency.injector.resolveArtistAlbumsPresenterActions(delegate: self)
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

extension ArtistAlbumsViewController: ArtistAlbumsViewActions {
    
}

extension ArtistAlbumsViewController: ArtistAlbumsPresenterDelegate {
    func loadUI() {
        
    }
    
    func itemsLoaded(items: [AlbumVO]) {
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
