//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Михаил Лоюк on 29.07.2021.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GlobalEnviroment())
        }
    }
}

    func calc(v1: Decimal, v2: Decimal, oper: String) -> String {
        var result: Decimal = 0
        switch oper {
        case "+": result = v1 + v2
        case "-": result = v1 - v2
        case "*": result = v1 * v2
        case "/": result = v1 / v2
        default: break
        }
        let resultToDisplay = NSDecimalNumber(decimal: result).stringValue
        return resultToDisplay.replacingOccurrences(of: ".", with: ",")
    }
