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
}

protocol ArtistSearchPresenterActions: BasePresenterActions {
    init(delegate: ArtistSearchPresenterDelegate)
    
    var items: [ArtistSearchVO]? { get }
    
    func viewDidLoad()
    func goToArtist(artistVO: ArtistSearchVO)
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
            return useCaseArtistSearch.execute(term: "Katy")
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
    
    func goToArtist(artistVO: ArtistSearchVO) {
        if let navigationController = delegate.navigationController {
                wireframe.goToView(from: navigationController, artistBO: artistVO.itemBO)
        }
    }
}
