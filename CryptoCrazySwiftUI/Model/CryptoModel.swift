//
//  CryptoModel.swift
//  CryptoCrazySwiftUI
//
//  Created by Osmancan Akagündüz on 30.04.2023.
//

import Foundation

class CryptoModel : Codable , Identifiable  {
    
    
    let id = UUID()
    let currency : String
    let price: String
    
    private enum CodingKeys: String,CodingKey {
        case currency = "currency"
        case price = "price"
    }
}
