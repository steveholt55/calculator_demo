//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calculationDisplayLabel: UILabel!

    @IBOutlet weak var clearButton: CalculatorButton!
    @IBOutlet weak var totalButton: CalculatorButton!
    
    @IBOutlet weak var divisionButton: CalculatorButton!
    @IBOutlet weak var multiplicationButton: CalculatorButton!
    @IBOutlet weak var subtractionButton: CalculatorButton!
    @IBOutlet weak var additionButton: CalculatorButton!
    
    @IBOutlet weak var zeroButton: CalculatorButton!
    @IBOutlet weak var oneButton: CalculatorButton!
    @IBOutlet weak var twoButton: CalculatorButton!
    @IBOutlet weak var threeButton: CalculatorButton!
    @IBOutlet weak var fourButton: CalculatorButton!
    @IBOutlet weak var fiveButton: CalculatorButton!
    @IBOutlet weak var sixButton: CalculatorButton!
    @IBOutlet weak var sevenButton: CalculatorButton!
    @IBOutlet weak var eightButton: CalculatorButton!
    @IBOutlet weak var nineButton: CalculatorButton!
    
    lazy var viewModel: CalculatorViewModel = {
        return CalculatorViewModel(displayLabel: self.calculationDisplayLabel)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButtons()
        // Do any additional setup after loading the view.
    }
    
    private func setupButtons() {
        
        self.clearButton.calculationType = CalculatorButtonType.action(.clear)
        self.totalButton.calculationType = CalculatorButtonType.action(.total)
        
        self.additionButton.calculationType = CalculatorButtonType.operation(.add)
        self.subtractionButton.calculationType = CalculatorButtonType.operation(.subtract)
        self.multiplicationButton.calculationType = CalculatorButtonType.operation(.multiply)
        self.divisionButton.calculationType = CalculatorButtonType.operation(.divide)
        
        self.zeroButton.calculationType = CalculatorButtonType.number(CalculationNumber(value: 0))
        self.oneButton.calculationType = CalculatorButtonType.number(CalculationNumber(value: 1))
        self.twoButton.calculationType = CalculatorButtonType.number(CalculationNumber(value: 2))
        self.threeButton.calculationType = CalculatorButtonType.number(CalculationNumber(value: 3))
        self.fourButton.calculationType = CalculatorButtonType.number(CalculationNumber(value: 4))
        self.fiveButton.calculationType = CalculatorButtonType.number(CalculationNumber(value: 5))
        self.sixButton.calculationType = CalculatorButtonType.number(CalculationNumber(value: 6))
        self.sevenButton.calculationType = CalculatorButtonType.number(CalculationNumber(value: 7))
        self.eightButton.calculationType = CalculatorButtonType.number(CalculationNumber(value: 8))
        self.nineButton.calculationType = CalculatorButtonType.number(CalculationNumber(value: 9))
        
        self.clearButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.totalButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        
        self.additionButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.subtractionButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.multiplicationButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.divisionButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        
        self.zeroButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.oneButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.twoButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.threeButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.fourButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.fiveButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.sixButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.sevenButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.eightButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.nineButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
    }
    
    @IBAction
    func calculatorButtonPressed(button: CalculatorButton) {
        guard let calculationType = button.calculationType else { return }
        self.viewModel.handleButtonPress(calculationType: calculationType)
    }
    
}

