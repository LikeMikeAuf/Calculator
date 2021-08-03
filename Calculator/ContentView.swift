//
//  ContentView.swift
//  Calculator
//
//  Created by Михаил Лоюк on 29.07.2021.
//

import SwiftUI

class GlobalEnviroment: ObservableObject {
    
    let digits: Set<CalculatorButtons> = [.decimal, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero]
    
    @Published var display = "0"
    
    @Published private var value1: Decimal = 0
    @Published private var value2: Decimal = 0
    @Published private var oper: String = ""
    @Published private var isTyping: Bool = false
    
    func recieveInput(calculatorButton: CalculatorButtons) {
        if digits.contains(calculatorButton) {
            if isTyping == false {
                if calculatorButton == .decimal {
                    display = "0,"
                } else {
                display = calculatorButton.title
                }
                isTyping = true
            } else if !display.contains(",") || calculatorButton != .decimal {
            self.display += calculatorButton.title
            }
        }
        switch calculatorButton {
        case .ac: display = "0"; isTyping = false
        case .plus, .minus, .multiply, .divide: operationPressed(operation: calculatorButton)
        case .equals: count(); display = calc(v1: value1, v2: value2, oper: oper)
        default: break
        }
    }
    func count() {
        isTyping = false
        value2 = Decimal.init(string: display.replacingOccurrences(of: ",", with: "."))!
    }
    func operationPressed(operation: CalculatorButtons) -> Void {
        value1 = Decimal.init(string: display.replacingOccurrences(of: ",", with: "."))!
        isTyping = false
        switch operation {
        case .plus: oper = "+"
        case .minus: oper = "-"
        case .multiply: oper = "*"
        case .divide: oper = "/"
        default: break
        }
    }
}

enum CalculatorButtons: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case plus, minus, divide, multiply, equals
    case ac, percent, plusMinus, decimal
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .plusMinus: return "±"
        case .percent: return "%"
        case .decimal: return ","
        case .equals: return "="
        default: return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .decimal, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine: return Color(.darkGray)
        case .ac, .plusMinus, .percent: return Color(.lightGray)
        default: return Color(.orange)
        }
    }
        
    var foregroundColor: Color {
        switch self {
        case .ac, .plusMinus, .percent: return Color(.black)
        default: return Color(.white)
        }
    }
}
    
struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnviroment
    
    let buttons: [[CalculatorButtons]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
        ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 72))
                }.padding()
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
    func buttonWidth(button: CalculatorButtons) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 3 * 12) / 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }

}

struct CalculatorButtonView: View {
    
    var button: CalculatorButtons
    @EnvironmentObject var env: GlobalEnviroment
    
    var body: some View {
        Button(action: {
            self.env.recieveInput(calculatorButton: button)
        }, label: {
            Text(button.title)
            .font(.system(size: 32))
            .foregroundColor(button.foregroundColor)
            .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
            .background(button.backgroundColor)
            .cornerRadius(self.buttonHeight() / 8)
        })
    }
    private func buttonWidth(button: CalculatorButtons) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 3 * 12) / 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    private func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnviroment())
    }
}

