//
//  MainViewModel.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Foundation
import Combine

class MainViewModel: ObservableObject{
    
    @Published var prices = [Crypto]()
    @Published var fetched = [Crypto]()
    @Published var isLoading = false
    
    @Published var launchLoading = true
    
    @Published var searchText: String = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        applySubscribers()
    }
    
    func fetchList() {
        isLoading = true
        Repository.shared.getList{ response in
            self.prices = response
            self.fetched = response
            self.isLoading = false
            self.launchLoading = false
        }
    }
    
    private func applySubscribers(){
        $searchText
            .combineLatest($fetched)
            .map{( text, startingCoins ) -> [Crypto] in
                guard !text.isEmpty else{
                    return startingCoins
                }
                let lowered = text.lowercased()
                return startingCoins.filter{ (coin) -> Bool in
                    return coin.name.lowercased().contains(lowered) ||
                        coin.symbol.lowercased().contains(lowered)
                }
            }
            .sink { [weak self] returned in
                self?.prices = returned
            }
            .store(in: &cancellable)
    }
    

}
