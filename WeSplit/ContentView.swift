//
//  ContentView.swift
//  WeSplit
//
//  Created by Nicolas Papegaey on 14/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Montant", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Nombre de personnes", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) personne(s)")
                        }
                    }
                }
                Section (header: Text("Combien de pourboire voulez-vous laisser ?") ){
                    Picker("Pourcentage de pourboire", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("\(totalPerPerson, specifier: "%.2f")€")
                        .foregroundColor(tipPercentages[tipPercentage]==0 ? .red : .blue)
                }
            }
            .navigationBarTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
