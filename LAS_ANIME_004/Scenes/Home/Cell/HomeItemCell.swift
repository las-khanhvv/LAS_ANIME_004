//
//  HomeItemCell.swift
//  BaseRxswift_MVVM
//
//  Created by Khanh Vu on 02/10/2023.
//

import UIKit
import SDWebImage

class HomeItemCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avataImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(_ item: AnimeQuoteDayModel) {
        avataImage.setImage(item.avatar, nil)
        nameLabel.text = item.animeName
//        SDImageCache.shared.clearMemory()
    }
    
}
