//
//  DetailViewModel.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 20/8/21.
//

import Foundation

class DetailViewModel: ObservableObject{
    
    @Published var detailData = CryptoDetail()
    @Published var isLoading = true
    
    func fetchDetail(id: String){
        isLoading = true
        Repository.shared.getDetail(id: id) { response in
            self.detailData = response
            self.isLoading = false
        }
    }
}
