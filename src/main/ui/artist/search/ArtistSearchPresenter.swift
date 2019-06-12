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

protocol ArtistSearchPresenterDelegate: AnyObject {
    func loadUI()
    func showError(_ error: Error)
    func showCenterLoader()
    func hideCenterLoader()
    func itemsLoaded(items: [ArtistSearchVO])
}

protocol ArtistSearchPresenterActions: BasePresenterActions {
    init(delegate: ArtistSearchPresenterDelegate)
    
    var items: [ArtistSearchVO]? { get }
    
    func viewDidLoad()
}

class ArtistSearchPresenter: BasePresenter {
    unowned var delegate: ArtistSearchPresenterDelegate
    private lazy var useCaseArtistSearch: UseCaseArtistSearch = {
        Dependency.injector.resolveUseCaseArtistSearch()
    }()
    private lazy var wireframe: ArtistSearchWireframeActions = {
        Dependency.injector.resolveArtistSearchWireframeActions()
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
        firstly { [weak self] () -> Promise<[ArtistBO]> in
            guard let self = self else { throw PMKError.cancelled }
            self.delegate.showCenterLoader()
            return useCaseArtistSearch.execute()
            }.map { (items: [ArtistBO]) in
                items.map { ArtistSearchVO(with: $0) }
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
