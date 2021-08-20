//
//  String.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 20/8/21.
//

import Foundation

extension String{
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
