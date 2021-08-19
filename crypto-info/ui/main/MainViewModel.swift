//
//  MainViewModel.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Foundation

class MainViewModel: ObservableObject{
    
    @Published var prices = [Crypto]()
    
    func fetchList() {
        Repository.shared.getList{ response in
            self.prices = response

        }
    }
    
    func fetchDetail(){
        Repository.shared.getDetail(id: "bitcoin") { response in
            
        }
    }
}
