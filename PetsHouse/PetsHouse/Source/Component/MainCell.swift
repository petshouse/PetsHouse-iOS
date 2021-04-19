//
//  MainCell.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/17.
//

import UIKit

import SnapKit

class MainCell: UITableViewCell {
    
    static let identifier = "mainCell"
    
    let profleImage = UIImageView().then {
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    let nameLbl = UILabel().then {
        $0.font = UIFont(name: "BMJUA", size: 25)
    }
    let timeLbl = UILabel().then {
        $0.font = UIFont(name: "BMJUA", size: 15)
    }
    let moreBtn = UIButton().then {
        $0.setImage(UIImage(named: "more"), for: .normal)
    }
    let titleTxtField = UITextField().then {
        $0.font = UIFont(name: "BMJUA", size: 20)
    }
    let contentTxtView = UITextView().then {
        $0.font = UIFont(name: "BMJUA", size: 15)
    }
    let postImage = UIImageView()
    let sirenLbl = UILabel()
    let sirenBtn = UIButton().then {
        $0.setImage(UIImage(named: "empty siren"), for: UIControl.State.normal)
        $0.setImage(UIImage(named: "siren"), for: UIControl.State.normal)
    }
    let statusLbl = UILabel().then {
        $0.font = UIFont(name: "BMJUA", size: 13)
        $0.textColor = .mainColor
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profleImage)
        addSubview(nameLbl)
        addSubview(timeLbl)
        addSubview(moreBtn)
        addSubview(titleTxtField)
        addSubview(contentTxtView)
        addSubview(postImage)
        addSubview(sirenLbl)
        addSubview(sirenBtn)
        addSubview(statusLbl)
        
        profleImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(snp.top).offset(15)
            $0.width.height.equalTo(50)
            $0.leading.equalTo(20)
        }
        nameLbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(snp.top).offset(15)
            $0.leading.equalTo(profleImage.snp.trailing).offset(15)
        }
        timeLbl.snp.makeConstraints {
            $0.top.equalTo(nameLbl.snp.bottom).offset(5)
            $0.leading.equalTo(profleImage.snp.trailing).offset(15)
        }
        moreBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.trailing.equalTo(-10)
            $0.leading.equalTo(timeLbl.snp.trailing).offset(30)
        }
        titleTxtField.snp.makeConstraints {
            $0.top.equalTo(profleImage.snp.bottom).offset(25)
            $0.leading.equalTo(30)
            $0.trailing.equalTo(-30)
        }
        contentTxtView.snp.makeConstraints {
            $0.top.equalTo(titleTxtField.snp.bottom).offset(18)
            $0.leading.equalTo(30)
            $0.trailing.equalTo(-30)
        }
        postImage.snp.makeConstraints {
            $0.top.equalTo(contentTxtView.snp.bottom).offset(18)
            $0.leading.equalTo(30)
            $0.trailing.equalTo(-30)
        }
        sirenLbl.snp.makeConstraints {
            $0.top.equalTo(postImage.snp.bottom).offset(23)
            $0.leading.equalTo(30)
        }
        sirenBtn.snp.makeConstraints {
            $0.leading.equalTo(sirenLbl.snp.trailing).offset(10)
            $0.top.equalTo(postImage.snp.bottom).offset(23)
        }
        statusLbl.snp.makeConstraints {
            $0.trailing.equalTo(-10)
            $0.leading.equalTo(sirenBtn.snp.trailing).offset(30)
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
