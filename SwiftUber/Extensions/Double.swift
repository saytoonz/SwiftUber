//
//  Double.swift
//  SwiftUber
//
//  Created by Sam on 28/02/2023.
//

import Foundation

extension Double {
    
    private var currencyFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.currencyCode = "GHS"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? ""
    }
    
}
