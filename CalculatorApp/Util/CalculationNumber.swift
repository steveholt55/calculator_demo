//
//  CalculationNumber.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import Foundation

struct CalculationNumber: CalulationButtonTypeable {
    
    let value: Int
    
    init(value: Int) {
        assert(value >= 0 && value <= 9, "Calculation Number value not in valid range")
        self.value = value
    }
    
    func stringValue() -> String {
        return "\(self.value)"
    }
}
