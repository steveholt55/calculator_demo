//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    // Normally I don't use Interface builder but felt it was appropriate for speed of hackaton type project.  Interface builder is great for some stuff but it gets you into a really bad anti pattern of coupling the ViewController with the View to closely.
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
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    lazy var viewModel: CalculatorViewModel = {
        return CalculatorViewModel(displayLabel: self.calculationDisplayLabel, resultsTableView: self.resultsTableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButtons()
        
        // Setup anonymous auth so we can use the firebase database
        Auth.auth().signInAnonymously() { (authResult, error) in
            self.viewModel.setupDatabaseObservers()
        }
    }
    
    private func setupButtons() {
        self.setupActionButtonTypes()
        self.setupOperationButtonTypes()
        self.setupNumberButtonTypes()
        
        self.setupActionButtonActions()
        self.setupOperationButtonActions()
        self.setupNumberButtonActions()
    }
    
    private func setupActionButtonTypes() {
        self.clearButton.calculationType = CalculatorButtonType.action(.clear)
        self.totalButton.calculationType = CalculatorButtonType.action(.total)
    }
    
    private func setupOperationButtonTypes() {
        self.additionButton.calculationType = CalculatorButtonType.operation(.add)
        self.subtractionButton.calculationType = CalculatorButtonType.operation(.subtract)
        self.multiplicationButton.calculationType = CalculatorButtonType.operation(.multiply)
        self.divisionButton.calculationType = CalculatorButtonType.operation(.divide)
    }
    
    private func setupNumberButtonTypes() {
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
    }
    
    private func setupActionButtonActions() {
        self.clearButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.totalButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
    }
    
    private func setupOperationButtonActions() {
        self.additionButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.subtractionButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.multiplicationButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
        self.divisionButton.addTarget(self, action: #selector(self.calculatorButtonPressed(button:)), for: .touchUpInside)
    }
    
    private func setupNumberButtonActions() {
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
    
    @objc
    func calculatorButtonPressed(button: CalculatorButton) {
        guard let calculationType = button.calculationType else { return }
        self.viewModel.handleButtonPress(calculationType: calculationType)
    }
    
}

