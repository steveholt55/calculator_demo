//
//  CalculationState.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import Foundation

enum CalculationState: String, Codable {
    case leftSide
    case operation
    case rightSide
    case done
}
