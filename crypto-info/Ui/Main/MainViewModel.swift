//
//  MainViewModel.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Foundation

class MainViewModel: ObservableObject{
    
    @Published var prices = [Crypto]()
    @Published var fetchedCoins = [Crypto]()
    @Published var isLoading = false
    
    func fetchList() {
        isLoading = true
        Repository.shared.getList{ response in
            self.prices = response
            self.isLoading = false
        }
    }
    
//    private func updateDb(){
//        PersistneceController.shared.deleteAllData()
//        for item in prices {
//            PersistneceController.shared.addCoin(object: item)
//        }
//        PersistneceController.shared.getAllData()
//        for item in PersistneceController.shared.coins{
//            fetchedCoins.append(
//                Crypto(
//                    id: item.id!,
//                    name: item.name!,
//                    image: item.image!,
//                    current_price: item.current_price,
//                    price_change_percentage_24h: item.price_change_percentage_24h,
//                    market_cap_rank: Int(item.market_cap_rank))
//            )
//        }
//    }
    
    func fetchDetail(){
        Repository.shared.getDetail(id: "bitcoin") { response in
            
        }
    }
}
