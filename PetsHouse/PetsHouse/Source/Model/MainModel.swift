//
//  MainModel.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/05.
//

import Foundation

class MainModel: Codable {
    let userId: String
    let nickname: String
    let title: String
    let description: String
    let media: String
    let date: String
    let totalJoin: Int
    let area: String
}
