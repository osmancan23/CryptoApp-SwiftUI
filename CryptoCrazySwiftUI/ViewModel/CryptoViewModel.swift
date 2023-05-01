//
//  CryptoViewModel.swift
//  CryptoCrazySwiftUI
//
//  Created by Osmancan Akagündüz on 30.04.2023.
//

import Foundation

@MainActor
class CryptoViewModel : ObservableObject {
    
   @Published var cryptoList = [CryptoModel] ()
    
    let cryptoService = CryptoService();
    
    
    
    func fetchCryptosContinuation(url:URL)async throws{
        let list =   try await cryptoService.fetchCryptosContinuation(url: url)
        
        self.cryptoList = list
    }
    
  /*
    func fetchCryptosAsync(url:URL) async throws {
        let list = try await  cryptoService.fetchCrpytosAsync(url: url)
        
        DispatchQueue.main.async {
            self.cryptoList = list
        }
    }*/
    
    /*
    func fetchCryptos(url:URL)  {
        cryptoService.fetchCryptos(url: url) { result in
            
            switch result {
                
            case .success(let list):
                self.cryptoList = list;
            
                
            case .failure(let error):
                print(error)
            
            
            }
        }
    }
    */
    
    
}
