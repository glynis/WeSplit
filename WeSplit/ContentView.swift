//
//  ContentView.swift
//  WeSplit
//
//  Created by Glynis Jones on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocussed: Bool
    @State private var checkAmount = 0.0 //setting up default values
    @State private var numberOfPeople = 2 //@State req bc we want people to enter things
    @State private var tipPercentage = 20 //also sets up data type (int vs double)
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2) //needs to be a double and also needs to add 2 because the form only goes 2..<100
        let tipSelection = Double(tipPercentage) //this also needs to be a double
        //now we have our input values
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let totalPerPerson = grandTotal / peopleCount
        
        return totalPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad) //to bring up num pad with . instead of keyboard
                        .focused($amountIsFocussed)
                    //TextField wants to take a string, not a double, but we tell it that it will be formatted as currency and it's ok
                    //This is telling Swift that whatever someone enters into the TextField will be our value for the checkAmount variable
                    //fancier structure:
                    //.currency(code: Locale.currency.currency?dentifier ?? "USD")
                    //Locale is a massive struct built into SwiftUI to check with users' region settings and if they don't have any just default to "USD"
                }
                Section("How much tip would you like to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                            //shows 4 people and not 2 because our default is 2 and our minimum is 2 so 2+2=4
                        }
                    }
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: "USD"))
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    if amountIsFocussed {
                        Button("Done"){
                            amountIsFocussed = false
                        }
                    }
                }
                //toolbar button for "amountIsFocussed" to be marked Done so that when you are done typing the check amount into the textfield you can exit the numpad
            }
        }
    }
}

#Preview { //doesn't exist in final app, only for xcode
    ContentView()
}
