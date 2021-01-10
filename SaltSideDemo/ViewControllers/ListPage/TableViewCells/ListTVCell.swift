//
//  ListTVCell.swift
//  SaltSideDemo
//
//  Created by Dinesh on 10/01/21.
//

import UIKit
import SDWebImage

class ListTVCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(user: UserModel) {
        self.userImageView.sd_setImage(with: URL(string: user.image ?? ""), completed: nil)
        self.nameLabel.text = user.title ?? ""
        self.descLabel.text = user.description ?? ""
    }
    
}
