//
//  Calculation.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import Foundation

class Calculation {
    var state: CalculationState = .leftSide {
        didSet {
            if state == .done {
                switch self.operation {
                case .add:
                    total = leftSide + rightSide
                case .subtract:
                    total = leftSide - rightSide
                case .divide:
                    total = leftSide / rightSide
                case .multiply:
                    total = leftSide * rightSide
                default:
                    break
                }
            }
        }
    }
    
    var leftSide: Int = 0
    var operation: CalculationOperation = .add
    var rightSide: Int = 0
    
    var total: Int = 0 // This Int because we are assuming no decimal numbers for this project
    
    func addToLeftSide(value: Int) {
        self.leftSide = Int("\(leftSide)\(value)") ?? 0
    }

    func addToRightSide(value: Int) {
        self.rightSide = Int("\(rightSide)\(value)") ?? 0
    }
}
