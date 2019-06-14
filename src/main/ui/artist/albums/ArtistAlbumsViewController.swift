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
    
    @IBOutlet weak var tableView: UITableView!
    //MARK: - Init
    
    required init(artistBO: ArtistBO, albumsBO: [AlbumBO]?) {
        super.init()
        presenter = Dependency.injector.resolveArtistAlbumsPresenterActions(delegate: self, artistBO: artistBO, albumsBO: albumsBO)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        //Last line
        self.presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //FIX problem with promt
        UINavigationBar.style.general.apply(to: self.navigationController?.navigationBar)
    }
    
    //MARK: - Custom methods
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ArtistAlbumsViewController: ArtistAlbumsViewActions {
    
}

extension ArtistAlbumsViewController: ArtistAlbumsPresenterDelegate {
    func loadUI() {
        navigationItem.title = L10n.albums
        
        self.navigationController?.navigationBar.backIndicatorImage = Asset.chevronLeft.image
        let backButtonItem = UIBarButtonItem(image: Asset.chevronLeft.image, style: .plain, target: self.navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        backButtonItem.title = nil
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        UINavigationBar.style.general.apply(to: self.navigationController?.navigationBar)
    }
    
    func itemsLoaded(item: AlbumDetailVO) {
        tableView.reloadData()
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
    }
}

extension ArtistAlbumsViewController: UITableViewDelegate {
}

extension ArtistAlbumsViewController: UITableViewDataSource {
    
    private func registerCells() {
        self.tableView.register(UINib(nibName: String(describing: AlbumCell.self), bundle: nil), forCellReuseIdentifier: AlbumCell.identifier)
        self.tableView.register(UINib(nibName: String(describing: ArtistHeaderCell.self), bundle: nil), forCellReuseIdentifier: ArtistHeaderCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.albumDetailVO.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellFinal = UITableViewCell.init()
        let item = presenter.albumDetailVO.content[indexPath.row]
        switch item {
        case .artist(let artist):
            if let cell = tableView.dequeueReusableCell(withIdentifier: ArtistHeaderCell.identifier, for: indexPath) as? ArtistHeaderCell {
                cell.load(artistVO: artist)
                cellFinal = cell
            }
        case .album(let album):
            if let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier, for: indexPath) as? AlbumCell {
                cell.load(album: album)
                cellFinal = cell
            }
        }
        return cellFinal
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension ArtistAlbumsViewController: UIGestureRecognizerDelegate {
    
}
