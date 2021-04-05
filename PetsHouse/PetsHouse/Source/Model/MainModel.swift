//
//  MainModel.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/05.
//

import Foundation

class MainModel: Codable {
    let userId: String
    let like: Int
    let view: Int
    let content: String
    let media: String
    let date: String
}
