//
//  ContentView.swift
//  flag guesss
//
//  Created by Ahmet Kağan Yörük on 6.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented=false
    @State private var alertTitle=""
    @State private var countries = ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"].shuffled()
    @State private var random = Int.random(in: 0..<3)
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: .black, location: 0.3),.init(color: .green, location: 0.3)
            ], center: .top, startRadius: 180, endRadius:600   ).ignoresSafeArea()
            VStack{
                VStack{
                    
                    Text("Select flag of").foregroundColor(.white)
                        .font(.subheadline.weight(.light))
                    
                    Text(countries[random]).foregroundColor(.white)
                        .font(.largeTitle.weight(.bold))
                }
                VStack{
                    ForEach(0..<3){item in
                        Button{
                            controlAnswer(item)
                        } label: {
                            Image(countries[item] )
                        }.clipShape(Capsule())
                            .shadow(radius: 40)
                        
                    }
                }
            }
            
        } .alert("", isPresented: $isPresented){
            Button("Tamam"){
                
            }.buttonStyle(.bordered)
        } message: {
            Text(alertTitle)
            
        }
    }
    func controlAnswer(_ number:Int){
        if random == number{
            alertTitle="Doğru"
        }
        else{ alertTitle="Yanlış"}
        
        isPresented=true
        countries=countries.shuffled()
        random=Int.random(in: 0..<3)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
