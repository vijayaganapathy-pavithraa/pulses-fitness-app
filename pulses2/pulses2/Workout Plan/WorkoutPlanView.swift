//
//  ContentView.swift
//  WorkoutPage
//
//  Created by Tessa on 4/8/24.
//

import SwiftUI

struct WorkoutPlanView: View {
    let options = ["Very Easy", "Easy", "Moderate", "Difficult", "Very Difficult"]
    @State private var selectedOption = 0
    @State private var quantity: Int = 10
    @State private var generatedPlan: [String] = []
    @State private var selection: Int? = nil
    
    var very_easy = [
        "Mountain Pose",
        "Child's Pose",
        "Easy Pose",
        "Corpse Pose",
        "Cat Pose",
        "Cow Pose",
        "Seated Forward Bend",
        "Happy Baby Pose",
        "Standing Forward Bend",
        "Reclined Bound Angle Pose"
    ]
    var easy = [
        "Downward-Facing Dog",
        "Warrior I",
        "Warrior II",
        "Bridge Pose",
        "Cobra Pose",
        "Tree Pose",
        "Cat-Cow Pose",
        "Triangle Pose",
        "Extended Side Angle Pose",
        "Low Lunge"
    ]
    var moderate = [
        "Chair Pose",
        "Half Moon Pose",
        "Revolved Triangle Pose",
        "Crow Pose",
        "Plank Pose",
        "Boat Pose",
        "Camel Pose",
        "Warrior III",
        "Pigeon Pose",
        "Four-Limbed Staff Pose"
    ]
    var difficult = [
        "Headstand",
        "Forearm Stand",
        "Side Plank Pose",
        "Wheel Pose",
        "Firefly Pose",
        "Dancer Pose",
        "Eight-Angle Pose",
        "Bound Angle Pose",
        "King Pigeon Pose",
        "Handstand"
    ]
    var very_difficult = [
        "Scorpion Pose",
        "Peacock Pose",
        "One-Legged King Pigeon Pose II",
        "Lotus Pose",
        "Flying Crow Pose",
        "Firefly Pose",
        "One-Handed Tree Pose",
        "Grasshopper Pose",
        "One-Handed Tiger Pose"
    ]
    
    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    ZStack {
                        VStack {
                            Text("Generate your workout plan:")
                                .font(.title)
                                .bold()
                            
                            HStack {
                                Image(systemName: "figure.cooldown")
                                    .foregroundColor(.cyan)
                                    .padding(.trailing, 4)
                                    .font(.title)
                                
                                Text("Level:")
                                    .font(.title)
                                
                                Text(options[selectedOption])
                                    .font(.title)
                                    .padding(.leading,4)
                                    .bold()
                                    .foregroundColor(.cyan)
                                
                            }
                            .padding()
                            
                            Picker("Options", selection: $selectedOption) {
                                ForEach(options.indices, id: \.self) { index in
                                    Text(options[index])
                                        .font(.title)
                                        .foregroundStyle(.blue)
                                }
                            }
                            .pickerStyle(.wheel)
                            .padding(.vertical, -5)
                            
                            Text("Duration of exercise (min)")
                                .font(.title)
                            Stepper(value: $quantity, in: 10...60, step: 10) {
                                Text("\(quantity)")
                            }
                            .padding(.horizontal, 120)
                            .bold()
                            .font(.title2)
                            .foregroundStyle(.blue)
                            
                            Button("Confirm") {
                                generatePlan()
                            }
                            .padding()
                            .foregroundColor(.bluePulsesText)
                            .background(Color.bluePulses.opacity(0.75))
                            .cornerRadius(10)
                            .font(.title3)
                            .bold()
                            .offset(y: 50)
                            
                            NavigationLink(destination: NextView(generatedPlan: generatedPlan, quantity: quantity), tag: 1, selection: $selection) {
                                EmptyView()
                            }
                        }
                    }
                }
                .tabItem {
                }.tag(0)
            }
        }
    }
    
    func generatePlan() {
        selection = 1
        let exercises: [String]
        
        switch options[selectedOption] {
        case "Very Easy":
            exercises = very_easy.shuffled()
        case "Easy":
            exercises = easy.shuffled()
        case "Moderate":
            exercises = moderate.shuffled()
        case "Difficult":
            exercises = difficult.shuffled()
        case "Very Difficult":
            exercises = very_difficult.shuffled()
        default:
            exercises = []
        }
        
        switch quantity {
        case 10:
            generatedPlan = Array(exercises.prefix(6))
        case 20:
            generatedPlan = Array(exercises.prefix(6))
        case 30:
            generatedPlan = Array(exercises.prefix(6))
        case 40:
            generatedPlan = Array(exercises.prefix(6))
        case 50:
            generatedPlan = Array(exercises.prefix(8))
        case 60:
            generatedPlan = Array(exercises.prefix(8))
        default:
            generatedPlan = []
        }
    }
}

struct ResultsView: View {
    @Binding var selectedPlan: [String]
    let quantity: Int
    @State private var selectedPoses: Set<String> = []
    @State private var randomNumbers: [Int] = []

    var body: some View {
        VStack {
            Text("Your workout plan:")
                .font(.largeTitle)
                .bold()
            
            List {
                ForEach(Array(selectedPlan.enumerated()), id: \.offset) { index, pose in
                    HStack {
                        Button(action: {
                            togglePoseSelection(pose)
                        }) {
                            Image(systemName: selectedPoses.contains(pose) ? "checkmark.square" : "square")
                                .foregroundColor(selectedPoses.contains(pose) ? .blue : .gray)
                        }
                        Text(pose)
                        Spacer()
                        if index < randomNumbers.count {
                            Text("\(randomNumbers[index]) min")
                        }
                    }
                }
            }
        }
        .onAppear {
            self.randomNumbers = generateRandomNumbers(quantity: quantity)
        }
    }
    
    func togglePoseSelection(_ pose: String) {
        if selectedPoses.contains(pose) {
            selectedPoses.remove(pose)
        } else {
            selectedPoses.insert(pose)
        }
    }
    
    func generateRandomNumbers(quantity: Int) -> [Int] {
        var minRange: Int
        var maxRange: Int
        
        switch quantity {
        case 10:
            minRange = 1
            maxRange = 3
        case 20:
            minRange = 2
            maxRange = 5
        case 30:
            minRange = 2
            maxRange = 7
        case 40:
            minRange = 4
            maxRange = 8
        case 50:
            minRange = 5
            maxRange = 8
        case 60:
            minRange = 6
            maxRange = 9
        default:
            minRange = 1
            maxRange = 3
        }
        
        var numbers = [Int]()
        var remainingQuantity = quantity
        
        while remainingQuantity > 0 {
            let actualMaxRange = max(minRange, min(maxRange, remainingQuantity))
            let randomNumber = Int.random(in: minRange...actualMaxRange)
            numbers.append(randomNumber)
            remainingQuantity -= randomNumber
        }
        
        let total = numbers.reduce(0, +)
        if total != quantity, let last = numbers.last {
            numbers[numbers.count - 1] = last + (quantity - total)
        }
        
        return numbers
    }
}

struct NextView: View {
    let generatedPlan: [String]
    let quantity: Int
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ZStack {
                ResultsView(selectedPlan: .constant(generatedPlan), quantity: quantity)
                    .scrollContentBackground(.hidden)
            }
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.backward")
            Text("Back")
        }
    }
    }
}

#Preview {
    WorkoutPlanView()
}
