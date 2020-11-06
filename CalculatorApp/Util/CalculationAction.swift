//
//  CalculationAction.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

enum CalculationAction: CalulationButtonTypeable {
    /// Clear the input
    case clear
    /// Total the input values
    case total
    /// Negate the current input
    case negation
    /// Add decimal to current input
    case decimal
    
    func stringValue() -> String {
        switch self {
        case .clear:
            return "C"
        case .total:
            return "="
        case .negation:
            return "NEG"
        case .decimal:
            return "."
        }
    }
}
