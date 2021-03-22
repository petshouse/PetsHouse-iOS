//
//  ViewModelType.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/03/22.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
