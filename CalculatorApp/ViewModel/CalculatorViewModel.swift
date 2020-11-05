//
//  CalculatorViewModel.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import Foundation
import UIKit

class CalculatorViewModel {
    
    let displayLabel: UILabel
    
    var currentCalculation: Calculation?
    
    init(displayLabel: UILabel) {
        self.displayLabel = displayLabel
    }
    
    func handleButtonPress(calculationType: CalculatorButtonType) {
        switch calculationType {
        case .action(let action):
            self.handleCalculationAction(action: action)
        case .number(let number):
            self.handleCalculationNumber(number: number)
        case .operation(let operation):
            self.handleCalculationOperation(operation: operation)
        }
    }
    
    private func handleCalculationAction(action: CalculationAction) {
        guard let currentCalculation = currentCalculation else {
            return
        }
        
        switch action {
        case .clear:
            self.displayLabel.text = "0"
            self.currentCalculation = nil
            break
        case .total:
            if currentCalculation.state == .rightSide {
                currentCalculation.state = .done
                self.displayLabel.text = "\(currentCalculation.total)"
            }
        default:
            break
        }
    }
    
    private func handleCalculationNumber(number: CalculationNumber) {
        guard let currentCalculation = currentCalculation, currentCalculation.state != .done else {
            self.currentCalculation = Calculation()
            self.handleCalculationNumber(number: number)
            return
        }
        
        switch currentCalculation.state {
        case .leftSide:
            currentCalculation.addToLeftSide(value: number.value)
            self.displayLabel.text = "\(currentCalculation.leftSide)"
        case .rightSide:
            currentCalculation.addToRightSide(value: number.value)
            self.displayLabel.text = "\(currentCalculation.rightSide)"
        default:
            break
        }
    }
    
    private func handleCalculationOperation(operation: CalculationOperation) {
        guard let currentCalculation = currentCalculation else {
            return
        }
        
        switch currentCalculation.state {
        case .leftSide:
            currentCalculation.operation = operation
            currentCalculation.state = .rightSide
            self.displayLabel.text = "0"
        default:
            break
        }
    }
}
