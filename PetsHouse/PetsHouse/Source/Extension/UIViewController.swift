//
//  UIViewController.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/04.
//

import Foundation
import UIKit

extension UIViewController {
    func pushVC(_ identifire: String) {
        let vc = storyboard?.instantiateViewController(identifier: identifire)
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func alert(_ title: String) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
