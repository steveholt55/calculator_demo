//
//  CalculationOperation.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import Foundation

enum CalculationOperation: String, CalulationButtonTypeable, Codable {
    /// Addition
    case add = "+"
    /// Subtraction
    case subtract = "-"
    /// Multiplication
    case multiply = "x"
    /// Division
    case divide = "/"
    /// Modulo
    case modulo = "%"
    
    func stringValue() -> String {
        return self.rawValue
    }
}
