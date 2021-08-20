//
//  DetailViewModel.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 20/8/21.
//

import Foundation

class DetailViewModel: ObservableObject{
    
    @Published var detailData = CryptoDetail()
    
    func fetchDetail(id: String){
        Repository.shared.getDetail(id: id) { response in
            self.detailData = response
        }
    }
}
