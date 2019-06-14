//
//  AlbumCell.swift
//  UnidadEditorialItunes
//
//  Created by Rafael Fernandez Alvarez on 13/06/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumCell: UITableViewCell {

    static let identifier = "AlbumCellIdentifier"
    
    @IBOutlet weak var imgAlbum: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIImageView.style.roundCorners(12.0).apply(to: imgAlbum)
        UILabel.style.titleDark(size: 16.0).apply(to: lbName)
        UILabel.style.grayBold(size: 14.0).apply(to: lbYear)
    }
    
    func load(album: AlbumVO) {
        imgAlbum.kf.setImage(with: album.image)
        lbName.text = album.name
        lbYear.text = album.date
    }
    
}
