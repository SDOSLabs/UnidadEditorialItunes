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
    private var presenter: ArtistAlbumsPresenterActions!
    
    //MARK: - Init
    
    required init(artistBO: ArtistBO) {
        super.init()
        presenter = Dependency.injector.resolveArtistAlbumsPresenterActions(delegate: self, artistBO: artistBO)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
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
        let loaderObject = LoaderManager.loader(loaderType: .indeterminateCircular(nil), inView: view, size: nil)
        LoaderManager.showLoader(loaderObject)
    }
    
    func hideCenterLoader() {
        LoaderManager.hideLoaderOfView(view)
    }
    
    func configureNavigationBar() {
        self.navigationItem.largeTitleDisplayMode = .never
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
