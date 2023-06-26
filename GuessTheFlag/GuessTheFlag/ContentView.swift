//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Venkatesh Nyamagoudar on 4/22/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score: Int = 0
    @State private var numberOfQuetions: Int = 1
    @State private var showingReset = false
    
    var body: some View {
        ZStack {
            //            LinearGradient(gradient: Gradient(colors: [.indigo, .yellow]), startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Touch the flag of")
                            .foregroundColor(.primary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagtapped(number)
                        } label: {
                            flagImage(name: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue",action: askNewQuetion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Congarts you got \(score) out of 8", isPresented: $showingReset) {
            Button("Reset", action: resetTheGame)
        } message: {
            Text("Presee Reset to Start New Game")
        }
    }
    
    func flagtapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong. That's the falg of \(countries[number])"
            score -= 1
        }
        showingScore = true
    }
    
    func askNewQuetion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        numberOfQuetions += 1
        if numberOfQuetions > 8 {
            showingReset = true
        }
    }
    
    func resetTheGame() {
        numberOfQuetions = 0
        score = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
