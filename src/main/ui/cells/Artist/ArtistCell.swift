//
//  ArtistCell.swift
//  UnidadEditorialItunes
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import UIKit
import PromiseKit

class ArtistCell: UITableViewCell {
    
    static let identifier = "ArtistCellIdentifier"
    
    private lazy var useCaseAlbumList: UseCaseAlbumList = {
        Dependency.injector.resolveUseCaseAlbumList()
    }()

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    
    @IBOutlet weak var imgPlaceholderAlbum1: UIImageView!
    @IBOutlet weak var viewAlbum1: UIView!
    @IBOutlet weak var imgAlbum1: UIImageView!
    @IBOutlet weak var lbNameAlbum1: UILabel!
    @IBOutlet weak var lbYearAlbum1: UILabel!
    
    @IBOutlet weak var imgPlaceholderAlbum2: UIImageView!
    @IBOutlet weak var viewAlbum2: UIView!
    @IBOutlet weak var imgAlbum2: UIImageView!
    
    @IBOutlet weak var lbNameAlbum2: UILabel!
    @IBOutlet weak var lbYearAlbum2: UILabel!
    
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var imgEmpty: UIImageView!
    @IBOutlet weak var lbEmpty: UILabel!
    private weak var artistVO: ArtistSearchVO?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgArrow.image = Asset.chevronRight.image
        imgPlaceholderAlbum1.image = Asset.placeholderList.image
        imgPlaceholderAlbum2.image = Asset.placeholderList.image
        imgEmpty.image = Asset.placeholderNoAlbum.image
        lbEmpty.text = L10n.noAlbums
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artistVO = nil
        imgAlbum1.image = nil
        imgAlbum2.image = nil
        imgPlaceholderAlbum1.isHidden = false
        imgPlaceholderAlbum2.isHidden = false
        viewAlbum1.isHidden = true
        viewAlbum2.isHidden = true
        lbNameAlbum1.text = ""
        lbNameAlbum2.text = ""
        lbYearAlbum1.text = ""
        lbYearAlbum2.text = ""
        
        viewEmpty.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func load(artistVO: ArtistSearchVO, albums: Promise<[AlbumVO]>) {
        self.artistVO = artistVO
        
        lbName.text = artistVO.name
        lbGenre.text = artistVO.genre ?? "-"
        
        albums.done { albums in
            if self.artistVO == artistVO {
                self.imgPlaceholderAlbum1.isHidden = true
                if albums.indices.contains(0) {
                    let album = albums[0]
                    self.viewAlbum1.isHidden = false
                    self.imgAlbum1.kf.setImage(with: album.image)
                    self.lbNameAlbum1.text = album.name
                    self.lbYearAlbum1.text = album.date
                } else {
                    self.viewAlbum1.isHidden = true
                    self.viewEmpty.isHidden = false
                }
                
                self.imgPlaceholderAlbum2.isHidden = true
                if albums.indices.contains(1) {
                    let album = albums[1]
                    self.viewAlbum2.isHidden = false
                    self.imgAlbum2.kf.setImage(with: album.image)
                    self.lbNameAlbum2.text = album.name
                    self.lbYearAlbum2.text = album.date
                } else {
                    self.viewAlbum2.isHidden = true
                }
            } else {
                print("NADA")
            }
            }.catch { _ in
                if self.artistVO == artistVO {
                    
                }
        }
    }
    
}
