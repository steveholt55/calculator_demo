//
//  PreviousCalculationCellView.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/5/20.
//

import Foundation
import UIKit

class PreviousCalculationCellView: UITableViewCell {
    
    static let reuseIdentifier: String = "PreviousCalculationCellView"
    
    private let calculationLabel = UILabel()
    
    var calculation: Calculation? {
        didSet {
            self.calculationLabel.attributedText = calculation?.attributedString
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Subviews
    
    private func setupSubviews() {
        self.calculationLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
        self.contentView.addSubview(self.calculationLabel)
    }
    
    private func setupConstraints() {
        self.calculationLabel.snp.makeConstraints {
            $0.edges.equalTo(self.contentView).inset(8)
        }
    }
}
