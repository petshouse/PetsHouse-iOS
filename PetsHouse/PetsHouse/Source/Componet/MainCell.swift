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
    
    let nameLbl = UILabel()
    let timeLbl = UILabel()
    let titleLbl = UILabel()
    let contentLbl = UILabel()
    let postImage = UIImageView()
    let sirenLbl = UILabel()
    let sirenBtn = UIButton().then {
        $0.setImage(UIImage(named: "empty siren"), for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profleImage)
        addSubview(nameLbl)
        addSubview(timeLbl)
        addSubview(titleLbl)
        addSubview(contentLbl)
        addSubview(postImage)
        addSubview(sirenLbl)
        addSubview(sirenBtn)
        
        profleImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
            $0.leading.equalTo(20)
        }
        nameLbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(profleImage.snp.trailing).offset(15)
        }
        timeLbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(profleImage.snp.trailing).offset(13)
            $0.top.equalTo(nameLbl.snp.bottom).offset(5)
        }
        titleLbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profleImage.snp.bottom).offset(25)
            $0.leading.equalTo(30)
            $0.trailing.equalTo(30)
        }
        contentLbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLbl.snp.bottom).offset(18)
            $0.leading.equalTo(30)
            $0.trailing.equalTo(30)
        }
        postImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentLbl.snp.bottom).offset(18)
            $0.leading.equalTo(30)
        }
        sirenLbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(postImage.snp.bottom).offset(23)
            $0.leading.equalTo(30)
        }
        sirenBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(sirenLbl.snp.trailing).offset(10)
            $0.top.equalTo(postImage.snp.bottom).offset(23)
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
