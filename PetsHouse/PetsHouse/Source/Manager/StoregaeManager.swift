//
//  StoregaeManager.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/02.
//

import Foundation

import Security

class StoregaeManager {
    
    static let shared = StoregaeManager()
    
    private let account = "PetsHouse"
    private let service = Bundle.main.bundleIdentifier
    
    let keyChainQuery: NSDictionary = [
        kSecClass : kSecClassGenericPassword,
        kSecAttrService : Bundle.main.bundleIdentifier ?? "default",
        kSecAttrAccount : "PetsHouse"
    ]
    
    func create(_ user: TokenModel) -> Bool {
        guard let data = try? JSONEncoder().encode(user) else { return false }
           
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service!,
            kSecAttrAccount : account,
            kSecValueData : data
        ]
           
        SecItemDelete(keyChainQuery)
           
        return SecItemAdd(keyChainQuery, nil) == errSecSuccess
    }
       
    func read() -> TokenModel? {
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service!,
            kSecAttrAccount : account,
            kSecReturnData : kCFBooleanTrue!,
            kSecMatchLimit : kSecMatchLimitOne
        ]
           
        var dataTypeRef: CFTypeRef?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        if status == errSecSuccess {
            let retrievedData = dataTypeRef as! Data
            let value = try? JSONDecoder().decode(TokenModel.self, from: retrievedData)
            return value
        }else {
            return nil
        }
    }
       
    func delete() -> Bool {
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service!,
            kSecAttrAccount : account
        ]
           
        return SecItemDelete(keyChainQuery) == noErr
    }
}
