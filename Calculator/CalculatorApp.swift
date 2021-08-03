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
