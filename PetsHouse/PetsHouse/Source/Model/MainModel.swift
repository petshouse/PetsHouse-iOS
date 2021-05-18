//
//  MainModel.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/05.
//

import Foundation

class MainModel: Codable {
    let num: Int
    let user: Int
    let title: String
    let description: String
    let mediaName: String
    let date: String
    let totalJoin: Int
    let area: String
}

class loadImageModel: Codable {
    let mediaName: String
}
