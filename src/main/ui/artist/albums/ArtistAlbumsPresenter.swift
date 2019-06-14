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
    func itemsLoaded(item: AlbumDetailVO)
    func configureNavigationBar()
}

protocol ArtistAlbumsPresenterActions: BasePresenterActions {
    init(delegate: ArtistAlbumsPresenterDelegate, artistBO: ArtistBO, albumsBO: [AlbumBO]?)
    
    var albumDetailVO: AlbumDetailVO { get }
    
    func viewDidLoad()
    func viewWillAppear()
}

class ArtistAlbumsPresenter: BasePresenter {
    unowned var delegate: ArtistAlbumsPresenterDelegate
    private lazy var useCaseAlbumList: UseCaseAlbumList = {
        Dependency.injector.resolveUseCaseAlbumList()
    }()
    private lazy var wireframe: ArtistAlbumsWireframeActions = {
        Dependency.injector.resolveArtistAlbumsWireframeActions()
    }()
    
    var albumDetailVO: AlbumDetailVO
    
    required init(delegate: ArtistAlbumsPresenterDelegate, artistBO: ArtistBO, albumsBO: [AlbumBO]?) {
        self.delegate = delegate
        self.albumDetailVO = AlbumDetailVO(with: albumsBO, artistBO: artistBO)
        super.init()
    }
    
    //MARK: - FilePrivate methods
    
}

extension ArtistAlbumsPresenter: ArtistAlbumsPresenterActions {
    func viewDidLoad() {
        delegate.loadUI()
        if albumDetailVO.albumsBO != nil {
            delegate.itemsLoaded(item: albumDetailVO)
        } else {
            firstly { [weak self] () -> Promise<[AlbumBO]> in
                guard let self = self else { throw PMKError.cancelled }
                self.delegate.showCenterLoader()
                return useCaseAlbumList.execute(id: albumDetailVO.artistVO.itemBO.artistId)
                }.map { (items: [AlbumBO]) in
                    AlbumDetailVO(with: items, artistBO: self.albumDetailVO.artistBO)
                }.done { [weak self] item in
                    guard let self = self else { throw PMKError.cancelled }
                    self.albumDetailVO = item
                    self.delegate.itemsLoaded(item: item)
                }.catch { [weak self] error in
                    guard let self = self else { return }
                    return self.delegate.showError(error)
                }.finally { [weak self] in
                    guard let self = self else { return }
                    return self.delegate.hideCenterLoader()
            }
        }
    }
    
    func viewWillAppear() {
        delegate.configureNavigationBar()
    }
}
