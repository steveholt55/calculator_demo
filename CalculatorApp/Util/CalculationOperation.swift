//
//  CalculationOperation.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import Foundation

enum CalculationOperation: CalulationButtonTypeable {
    /// Addition
    case add
    /// Subtraction
    case subtract
    /// Multiplication
    case multiply
    /// Division
    case divide
    /// Modulo
    case modulo
    
    func stringValue() -> String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .multiply:
            return "x"
        case .divide:
            return "/"
        case .modulo:
            return "%"
        }
    }
}
