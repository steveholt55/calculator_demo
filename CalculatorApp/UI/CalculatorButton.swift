//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import Foundation
import UIKit
import SnapKit

enum CalculatorButtonType {
    case number(CalculationNumber)
    case operation(CalculationOperation)
    case action(CalculationAction)
}

class CalculatorButton: UIButton {
    
    private let backgroundCircle = UIView()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .black)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    var calculationType: CalculatorButtonType? {
        didSet {
            guard let calculationType = calculationType else { return }
            switch calculationType {
            case .action(let action):
                self.label.text = action.stringValue()
                self.label.textColor = .white
                self.backgroundCircle.backgroundColor = .systemRed
            case .operation(let operation):
                self.label.text = operation.stringValue()
                self.label.textColor = .white
                self.backgroundCircle.backgroundColor = .red
            case .number(let number):
                self.label.text = number.stringValue()
                self.label.textColor = .white
                self.backgroundCircle.backgroundColor = .red
            }
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupSubviews()
        self.setupConstraints()
    }
    
    
    // MARK: - Layout
    
    private func setupSubviews() {
        self.addSubview(self.backgroundCircle)
        self.backgroundCircle.addSubview(self.label)
        self.backgroundCircle.isUserInteractionEnabled = false
        self.label.isUserInteractionEnabled = false
    }
    
    private func setupConstraints() {
        self.backgroundCircle.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        self.label.snp.makeConstraints {
            $0.edges.equalTo(self.backgroundCircle).inset(4)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundCircle.layer.cornerRadius = self.backgroundCircle.frame.height / 2
    }
    
}
