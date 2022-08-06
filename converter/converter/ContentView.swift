//
//  ContentView.swift
//  converter
//
//  Created by Ahmet Kağan Yörük on 1.08.2022.
//

import SwiftUI



struct ContentView: View {
    let formatter:MeasurementFormatter
    init(){
        formatter=MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .medium
    }
    
    @State private var type=3
    @State public var unitFrom:Dimension=UnitTemperature.celsius
    @State public var valueFrom = 0.0
    @State public var unitTo:Dimension=UnitTemperature.fahrenheit
    @State public var valueTo = 0.0
    
    @FocusState private var Focused: Bool
    
    
    let ConvertTypes=["Volume","Time","Length","Tempature"]
    
    let Units=[
        [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons],
        [ UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours],
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [ UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    ]
    
    
    func convert()->String{
        let from = Measurement(value: valueFrom, unit: unitFrom)
        let toConvert = from.converted(to: unitTo)
        return formatter.string(from: toConvert)
    }
    
    
    
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Flavor", selection: $type) {
                        ForEach(0..<ConvertTypes.count,id:\.self){
                            Text(ConvertTypes[$0])
                        }
                    }
                }
                Section{
                    TextField("Value", value: $valueFrom,format: .number).keyboardType(.numberPad).toolbar{
                        ToolbarItemGroup(placement:.keyboard){
                            Button("Done"){
                                Focused=false
                            }
                        }
                    }.focused($Focused)
                } header: {
                    Text("Amount")
                }
                Section{    
                    Picker("From", selection: $unitFrom){
                        ForEach(Units[type],id:\.self){
                            Text(formatter.string(from: $0))
                        }
                    }
                    
                    
                    Picker("To", selection: $unitTo) {
                        ForEach(Units[type],id:\.self){
                            Text(formatter.string(from: $0))
                        }
                    }
                }.onChange(of: type){
                    selection in
                    unitFrom = Units[selection][0]
                    unitTo=Units[selection][1]
                }
                Section{
                    Text(convert())
                }header: {
                    Text("Result")
                }
            }
            
        }.navigationBarTitle("Converter")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
