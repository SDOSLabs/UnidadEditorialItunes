//
//  ArtistSearchViewController.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit
import SDOSLoader


/*
 Dependency register JSON
 
 {
    "dependencyName": "ArtistSearchViewActions",
    "className": "ArtistSearchViewController"
 }
 */

protocol ArtistSearchViewActions: BaseViewActions, ArtistSearchPresenterDelegate {
    
}

class ArtistSearchViewController: BaseViewController {
    private lazy var presenter: ArtistSearchPresenterActions = {
        Dependency.injector.resolveArtistSearchPresenterActions(delegate: self)
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewNoResults: UIView!
    @IBOutlet weak var lbTitleNoResults: UILabel!
    @IBOutlet weak var lbSubtitleNoResults: UILabel!
    
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var imgEmpty: UIImageView!
    @IBOutlet weak var lbEmpty: UILabel!
    
    var loaderObject: LoaderObject?
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

}

extension ArtistSearchViewController: ArtistSearchViewActions {
    
}

extension ArtistSearchViewController: ArtistSearchPresenterDelegate {
    func loadUI() {
        navigationItem.title = L10n.searchArtist
        lbTitleNoResults.text = L10n.noResults
        lbEmpty.text = L10n.textEmptyView
        imgEmpty.image = Asset.placeholder.image
        
        viewNoResults.alpha = 0
        tableView.alpha = 0
        viewEmpty.alpha = 1

    }
    
    func itemsLoaded(items: [ArtistSearchVO]) {
        print("Results: \(items.count) elements")
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        lbSubtitleNoResults.text = L10n.errorWs
        UIView.animate(withDuration: 0.3) {
            self.viewNoResults.alpha = 1
            self.tableView.alpha = 0
            self.viewEmpty.alpha = 0
        }
    }
    
    func showCenterLoader() {
        UIView.animate(withDuration: 0.3) {
            self.viewNoResults.alpha = 0
            self.tableView.alpha = 0
            self.viewEmpty.alpha = 0
        }
        loaderObject = LoaderManager.loader(loaderType: .indeterminateCircular(nil), inView: view, size: nil)
        if let loaderObject = loaderObject {
            LoaderManager.showLoader(loaderObject)
        }
    }
    
    func hideCenterLoader() {
        if let loaderObject = loaderObject {
            LoaderManager.hideLoader(loaderObject)
        }
        loaderObject = nil
    }
    
    func loadSearchComponent() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = L10n.name
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
    }
    
    func showResults() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        UIView.animate(withDuration: 0.3) {
            self.viewNoResults.alpha = 0
            self.tableView.alpha = 1
            self.viewEmpty.alpha = 0
        }
    }
    
    func showEmptyView() {
        UIView.animate(withDuration: 0.3) {
            self.viewNoResults.alpha = 0
            self.tableView.alpha = 0
            self.viewEmpty.alpha = 1
        }
    }
    
    func showNoResultView() {
        lbSubtitleNoResults.text = L10n.noResultsTerm(navigationItem.searchController?.searchBar.text ?? "")
        UIView.animate(withDuration: 0.3) {
            self.viewNoResults.alpha = 1
            self.tableView.alpha = 0
            self.viewEmpty.alpha = 0
        }
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .charcoalGrey
        self.navigationItem.searchController?.searchBar.barTintColor = .white
        self.navigationItem.searchController?.searchBar.tintColor = .white

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]


    }
}

extension ArtistSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.goToArtist(withIndex: indexPath.row)
    }
}

extension ArtistSearchViewController: UITableViewDataSource {
    
    private func registerCells() {
        self.tableView.register(UINib(nibName: String(describing: ArtistCell.self), bundle: nil), forCellReuseIdentifier: ArtistCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellFinal = UITableViewCell.init()
        if let artist = presenter.items?[indexPath.row] {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ArtistCell.identifier, for: indexPath) as? ArtistCell {
                cell.load(artistVO: artist, albums: presenter.loadAlbums(for: artist))
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

extension ArtistSearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter.search(term: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        if !searchBar.isFirstResponder {
            presenter.search(term: searchBar.text)
        }
    }
}

extension ArtistSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
