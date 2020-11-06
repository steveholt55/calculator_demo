//
//  Calculation.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import Foundation
import UIKit
import Firebase

class Calculation: Codable {
    let id: String
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
    
    let date: Date
    
    var total: Int = 0 // This Int because we are assuming no decimal numbers for this project
    
    public init() {
        self.id = UUID.init().uuidString
        self.date = Date()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        let state = try container.decode(CalculationState.self, forKey: .state)
        let leftSide = try container.decode(Int.self, forKey: .leftSide)
        let operation = try container.decode(CalculationOperation.self, forKey: .operation)
        let rightSide = try container.decode(Int.self, forKey: .rightSide)
        let total = try container.decode(Int.self, forKey: .total)
        let date = try container.decode(Date.self, forKey: .date)
        
        self.id = id
        self.state = state
        self.leftSide = leftSide
        self.rightSide = rightSide
        self.operation = operation
        self.total = total
        self.date = date
    }
    
    func addToLeftSide(value: Int) {
        self.leftSide = Int("\(leftSide)\(value)") ?? 0
    }

    func addToRightSide(value: Int) {
        self.rightSide = Int("\(rightSide)\(value)") ?? 0
    }
    
    var attributedString: NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: "")
        attributedString.append(NSAttributedString(string: "\(leftSide)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed]))
        attributedString.append(NSAttributedString(string: " \(operation.rawValue) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]))
        attributedString.append(NSAttributedString(string: "\(rightSide)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed]))
        attributedString.append(NSAttributedString(string: " = ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]))
        attributedString.append(NSAttributedString(string: "\(total)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed]))
        return attributedString
    }
}

// MARK: - CodingKey
private extension Calculation {
    
    enum CodingKeys: String, CodingKey {
        case id         = "id"
        case state      = "state"
        case leftSide   = "left_side"
        case operation  = "operation"
        case rightSide  = "right_side"
        case total      = "total"
        case date       = "date"
    }
}
