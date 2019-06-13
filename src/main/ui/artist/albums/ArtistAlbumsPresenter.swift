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
    func configureNavigationBar()
}

protocol ArtistAlbumsPresenterActions: BasePresenterActions {
    init(delegate: ArtistAlbumsPresenterDelegate, artistBO: ArtistBO, albumsBO: [AlbumBO]?)
    
    var albumsVO: [AlbumVO]? { get }
    var artistVO: ArtistSearchVO { get }
    
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
    
    var albumsVO: [AlbumVO]? = nil
    let artistVO: ArtistSearchVO
    
    required init(delegate: ArtistAlbumsPresenterDelegate, artistBO: ArtistBO, albumsBO: [AlbumBO]?) {
        self.delegate = delegate
        self.artistVO = ArtistSearchVO(with: artistBO)
        if let albumsBO = albumsBO {
            self.albumsVO = albumsBO.map{ AlbumVO(with: $0) }
        }
        super.init()
    }
    
    //MARK: - FilePrivate methods
    
}

extension ArtistAlbumsPresenter: ArtistAlbumsPresenterActions {
    func viewDidLoad() {
        delegate.loadUI()
        if let albumsVO = albumsVO {
            delegate.itemsLoaded(items: albumsVO)
        } else {
            firstly { [weak self] () -> Promise<[AlbumBO]> in
                guard let self = self else { throw PMKError.cancelled }
                self.delegate.showCenterLoader()
                return useCaseAlbumList.execute(id: self.artistVO.itemBO.artistId)
                }.map { (items: [AlbumBO]) in
                    items.map { AlbumVO(with: $0) }
                }.done { [weak self] items in
                    guard let self = self else { throw PMKError.cancelled }
                    self.albumsVO = items
                    self.delegate.itemsLoaded(items: items)
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
