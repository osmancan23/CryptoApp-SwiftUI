//
//  CryptoService.swift
//  CryptoCrazySwiftUI
//
//  Created by Osmancan Akagündüz on 30.04.2023.
//

import Foundation

class CryptoService {
    
    
    
    // Aync-Await
    func fetchCrpytosAsync(url:URL) async throws -> [CryptoModel] {
       
            let (data,_) =  try await   URLSession.shared.data(from: url)
            
            let cryptoList = try? JSONDecoder().decode([CryptoModel].self, from: data)
        
       
            return cryptoList ?? []
        
    }
    
    // Task
    func fetchCryptos(url: URL , complete:@escaping  (Result<[CryptoModel],NetworkError>) -> Void)  {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                complete(.failure(NetworkError.notFound))
            }
            
            guard let data = data, error == nil else {
                       return complete(.failure(.noData))
                   }
            guard let currencies = try? JSONDecoder().decode([CryptoModel].self, from: data) else {
                return complete(.failure(.parseError))
                  }
            
            complete(.success(currencies))
            
        }.resume()
    }
    
    // Task -> Asyn-Await
    func fetchCryptosContinuation(url:URL) async throws -> [CryptoModel] {
      try await  withCheckedThrowingContinuation{
            continuation in fetchCryptos(url: url) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let list):
                    continuation.resume(returning: list)
                }
            }
        }
    }
}


enum NetworkError : Error{
    case notFound
    case parseError
    case noData
}
