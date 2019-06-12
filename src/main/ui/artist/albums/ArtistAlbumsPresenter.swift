//
//  ArtistAlbumsPresenter.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit
import SDOSVIPER
import PromiseKit

/*
 Dependency register JSON
 
 {
    "dependencyName": "ArtistAlbumsPresenterActions",
    "className": "ArtistAlbumsPresenter",
    "arguments": [
        {
            "name": "delegate",
            "type": "ArtistAlbumsPresenterDelegate"
        }
    ]
 }
 */

protocol ArtistAlbumsPresenterDelegate: AnyObject {
    func loadUI()
    func showError(_ error: Error)
    func showCenterLoader()
    func hideCenterLoader()
    func itemsLoaded(items: [AlbumVO])
}

protocol ArtistAlbumsPresenterActions: BasePresenterActions {
    init(delegate: ArtistAlbumsPresenterDelegate, artistBO: ArtistBO)
    
    var items: [AlbumVO]? { get }
    
    func viewDidLoad()
}

class ArtistAlbumsPresenter: BasePresenter {
    unowned var delegate: ArtistAlbumsPresenterDelegate
    private lazy var useCaseAlbumList: UseCaseAlbumList = {
        Dependency.injector.resolveUseCaseAlbumList()
    }()
    private lazy var wireframe: ArtistAlbumsWireframeActions = {
        Dependency.injector.resolveArtistAlbumsWireframeActions()
    }()
    
    var items: [AlbumVO]?
    let artistBO: ArtistBO
    
    required init(delegate: ArtistAlbumsPresenterDelegate, artistBO: ArtistBO) {
        self.delegate = delegate
        self.artistBO = artistBO
        super.init()
    }
    
    //MARK: - FilePrivate methods
    
}

extension ArtistAlbumsPresenter: ArtistAlbumsPresenterActions {
    func viewDidLoad() {
        delegate.loadUI()
        firstly { [weak self] () -> Promise<[AlbumBO]> in
            guard let self = self else { throw PMKError.cancelled }
            self.delegate.showCenterLoader()
            return useCaseAlbumList.execute(id: self.artistBO.artistId)
            }.map { (items: [AlbumBO]) in
                items.map { AlbumVO(with: $0) }
            }.done { [weak self] items in
                guard let self = self else { throw PMKError.cancelled }
                return self.delegate.itemsLoaded(items: items)
            }.catch { [weak self] error in
                guard let self = self else { return }
                return self.delegate.showError(error)
            }.finally { [weak self] in
                guard let self = self else { return }
                return self.delegate.hideCenterLoader()
        }
    }
}
