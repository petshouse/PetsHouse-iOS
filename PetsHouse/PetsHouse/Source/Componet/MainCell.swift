//
//  MainCell.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/12.
//

import UIKit

class MainCell: UITableViewCell {
    
    let profleImage = UIImageView().then {
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    let userNameLbl = UILabel()
    let timeLbl = UILabel()
    let contentLbl = UILabel()
    let postImage = UIImageView()
    let sirenBtn = UIButton().then {
        $0.setImage(UIImage(named: "empty siren"), for: .normal)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
