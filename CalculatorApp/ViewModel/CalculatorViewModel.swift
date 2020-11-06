//
//  CalculatorViewModel.swift
//  CalculatorApp
//
//  Created by Brandon Jenniges on 11/4/20.
//

import Foundation
import UIKit
import Firebase

class CalculatorViewModel: NSObject {
    
    let displayLabel: UILabel
    let resultsTableView: UITableView
    
    var currentCalculation: Calculation?
    var previousCalculations: [Calculation] = []
    
    lazy var database: DatabaseReference = {
        Database.database().reference(withPath: "calculations")
    }()
    
    init(displayLabel: UILabel, resultsTableView: UITableView) {
        self.displayLabel = displayLabel
        self.resultsTableView = resultsTableView
        super.init()
        self.resultsTableView.register(PreviousCalculationCellView.self, forCellReuseIdentifier: PreviousCalculationCellView.reuseIdentifier)
        self.resultsTableView.dataSource = self
    }
    
    // MARK: Firebase Database
    
    /// Build item to send to Firebase datastore
    private func saveCalculation() {
        guard let currentCalculation = self.currentCalculation else { return }
        let jsonData = try! JSONEncoder().encode(currentCalculation)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        let calculationItemRef = self.database.child(currentCalculation.id)
        calculationItemRef.setValue(jsonString)
    }
    
    func setupDatabaseObservers() {
        
        /// Handle new firebase data updates
        self.database.observe(.value, with: { snapshot in
            
            var newItems: [Calculation] = []
            
            let decoder = JSONDecoder()
            for child in snapshot.children {
                // Create new instance from JSON. Bigger project would refactor into a better network handling layer
                if let snapshot = child as? DataSnapshot {
                    if let data = (snapshot.value as? String)?.data(using: .utf8), let calculation = try? decoder.decode(Calculation.self, from: data) {
                        newItems.append(calculation)
                    }
                }
            }
            
            // Only show most recent 10
            self.previousCalculations = Array(newItems.sorted { $0.date > $1.date }.prefix(10))
            self.resultsTableView.reloadData()
        })
        
        self.database.queryLimited(toFirst: 10)
    }
    
    // MARK: - Button Press
    
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
                self.saveCalculation()
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

extension CalculatorViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.previousCalculations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreviousCalculationCellView.reuseIdentifier, for: indexPath) as? PreviousCalculationCellView else {
            fatalError()
        }
        cell.calculation = self.previousCalculations[indexPath.item]
        
        return cell
    }
}
