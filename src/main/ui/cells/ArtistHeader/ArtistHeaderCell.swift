//
//  ArtistHeaderCell.swift
//  UnidadEditorialItunes
//
//  Created by Rafael Fernandez Alvarez on 14/06/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import UIKit

class ArtistHeaderCell: UITableViewCell {
    
    static let identifier = "ArtistHeaderCellIdentifier"

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var viewSeparator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        UILabel.style.titleDark(size: 18.0).apply(to: lbName)
        UILabel.style.titleBlue(size: 16.0).apply(to: lbGenre)
        
        UIView.style.separator.apply(to: viewSeparator)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func load(artistVO: ArtistSearchVO) {
        lbName.text = artistVO.name
        lbGenre.text = artistVO.genre
    }
    
}
