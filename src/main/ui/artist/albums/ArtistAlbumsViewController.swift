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
    
    //MARK: - Custom methods
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setTitle(title: String, subtitle: String?) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.white
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        
        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        
        return titleView
    }
}

extension ArtistAlbumsViewController: ArtistAlbumsViewActions {
    
}

extension ArtistAlbumsViewController: ArtistAlbumsPresenterDelegate {
    func loadUI() {
        navigationItem.titleView = setTitle(title: presenter.artistVO.name, subtitle: presenter.artistVO.genre)
        
        self.navigationController?.navigationBar.backIndicatorImage = Asset.chevronLeft.image
        let backButtonItem = UIBarButtonItem(image: Asset.chevronLeft.image, style: .plain, target: self.navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        backButtonItem.title = nil
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = self


    }
    
    func itemsLoaded(items: [AlbumVO]) {
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
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .charcoalGrey
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension ArtistAlbumsViewController: UITableViewDelegate {
}

extension ArtistAlbumsViewController: UITableViewDataSource {
    
    private func registerCells() {
        self.tableView.register(UINib(nibName: String(describing: AlbumCell.self), bundle: nil), forCellReuseIdentifier: AlbumCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.albumsVO?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellFinal = UITableViewCell.init()
        if let album = presenter.albumsVO?[indexPath.row] {
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
