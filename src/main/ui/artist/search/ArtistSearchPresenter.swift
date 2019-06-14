//
//  ArtistSearchPresenter.swift
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
    "dependencyName": "ArtistSearchPresenterActions",
    "className": "ArtistSearchPresenter",
    "arguments": [
        {
            "name": "delegate",
            "type": "ArtistSearchPresenterDelegate"
        }
    ]
 }
 */

protocol ArtistSearchPresenterDelegate: UIViewController {
    func loadUI()
    func showError(_ error: Error)
    func showCenterLoader()
    func hideCenterLoader()
    func itemsLoaded(items: [ArtistSearchVO])
    func loadSearchComponent()
    func showResults()
    func showEmptyView()
    func showNoResultView()
    func configureNavigationBar()
}

protocol ArtistSearchPresenterActions: BasePresenterActions {
    init(delegate: ArtistSearchPresenterDelegate)
    
    var items: [ArtistSearchVO]? { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func goToArtist(withIndex index: Int)
    func search(term: String?)
    
    func loadAlbums(for artist: ArtistSearchVO) -> Promise<[AlbumVO]>
}

class ArtistSearchPresenter: BasePresenter {
    unowned var delegate: ArtistSearchPresenterDelegate
    private lazy var useCaseArtistSearch: UseCaseArtistSearch = {
        Dependency.injector.resolveUseCaseArtistSearch()
    }()
    private lazy var wireframe: ArtistSearchWireframeActions = {
        Dependency.injector.resolveArtistSearchWireframeActions()
    }()
    private lazy var useCaseAlbumList: UseCaseAlbumList = {
        Dependency.injector.resolveUseCaseAlbumList()
    }()
    
    var items: [ArtistSearchVO]?
    
    required init(delegate: ArtistSearchPresenterDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    //MARK: - FilePrivate methods
    
}

extension ArtistSearchPresenter: ArtistSearchPresenterActions {
    func viewDidLoad() {
        delegate.loadUI()
        delegate.loadSearchComponent()
    }
    
    func viewWillAppear() {
        delegate.configureNavigationBar()
    }
    
    func goToArtist(withIndex index: Int) {
        if let navigationController = delegate.navigationController, let artistVO = items?[index] {
            wireframe.goToView(from: navigationController, artistBO: artistVO.itemBO, albumsBO: artistVO.albums?.map({ $0.itemBO }))
        }
    }
    
    func search(term: String?) {
        guard let term = term, !term.isEmpty else {
            delegate.showEmptyView()
            return
        }
        
        firstly { [weak self] () -> Promise<[ArtistBO]> in
            guard let self = self else { throw PMKError.cancelled }
            self.delegate.showCenterLoader()
            return useCaseArtistSearch.execute(term: term)
            }.map { (items: [ArtistBO]) in
                items.map { ArtistSearchVO(with: $0) }
            }.done { [weak self] items in
                guard let self = self else { throw PMKError.cancelled }
                self.items = items
                if items.isEmpty {
                    self.delegate.showNoResultView()
                } else {
                    self.delegate.itemsLoaded(items: items)
                    self.delegate.showResults()
                }
            }.catch { [weak self] error in
                guard let self = self else { return }
                return self.delegate.showError(error)
            }.finally { [weak self] in
                guard let self = self else { return }
                return self.delegate.hideCenterLoader()
        }
    }
    
    func loadAlbums(for artist: ArtistSearchVO) -> Promise<[AlbumVO]> {
        if let albums = artist.albums {
            return Promise<[AlbumVO]>{ seal in
                seal.fulfill(albums)
            }
        } else {
            return Promise<[AlbumVO]>{ seal in
                firstly { () -> Promise<[AlbumBO]> in
                    return useCaseAlbumList.execute(id: artist.itemBO.artistId)
                    }.map { (items: [AlbumBO]) in
                        items.map { AlbumVO(with: $0) }
                    }.done { [weak self] albums in
                        guard let self = self else { throw PMKError.cancelled }
                        var count = 0
                        if let items = self.items {
                            for item in items {
                                if item == artist {
                                    item.albums = albums
                                    break
                                }
                                count += 1
                            }
                        }
                        seal.fulfill(albums)
                    }.catch { error in
                        seal.reject(error)
                }
            }
        }
    }
}
