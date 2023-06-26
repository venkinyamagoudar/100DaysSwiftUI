//
//  ContentView-ViewModel.swift
//  GuessTheFlag
//
//  Created by Venkatesh Nyamagoudar on 6/3/23.
//

import SwiftUI

extension ContentView {
    @MainActor class ContentViewViewModel: ObservableObject {
        @Published var score: Int = 0
        @Published var numberOfQuestions: Int = 1
        @Published var showingReset: Bool = false
        @Published var showingScore: Bool = false
        @Published var scoreTitle: String = ""
        @Published var countries: [String] = []
        @Published var correctAnswer: Int = 0
        
        let labels = [
            "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
            "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
            "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
            "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
            "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
            "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
            "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
            "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
            "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
            "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
            "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
        ]
        
        var correctCountry: String {
            return countries[correctAnswer]
        }
        
        init() {
            self.startNewGame()
        }
        
        func flagTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong. That's the flag of \(countries[number])"
                score -= 1
            }
            Task { @MainActor in
                showingScore = true
            }
        }
        
        func askNewQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            numberOfQuestions += 1
            if numberOfQuestions > 8 {
                Task { @MainActor in
                    showingReset = true
                }
            }
        }
        
        func resetTheGame() {
            numberOfQuestions = 1
            score = 0
            startNewGame()
        }
        
        private func startNewGame() {
            countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
            correctAnswer = Int.random(in: 0...2)
        }
    }
}
