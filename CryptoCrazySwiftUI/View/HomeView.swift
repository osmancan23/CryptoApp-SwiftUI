//
//  ContentView.swift
//  CryptoCrazySwiftUI
//
//  Created by Osmancan Akagündüz on 30.04.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var cryptoViewModel : CryptoViewModel
    
    
    init() {
        self.cryptoViewModel = CryptoViewModel()    }
    
    
    
    var body: some View {
    
        NavigationView {
            List(cryptoViewModel.cryptoList){crypto in
                
                VStack{
                    Text(crypto.currency)
                    Text(crypto.price)
                }
                
            }.toolbar(content: {
                Button {
                    Task.init {
                        cryptoViewModel.cryptoList = []
                                             try?  await cryptoViewModel.fetchCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)   
                    }
                                 } label: {
                    Text("refresh")
                }

            }) .navigationTitle("Crypto List")
        }.task {
         try? await  cryptoViewModel.fetchCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
