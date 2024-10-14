//
//  ContentView.swift
//  whatWorkouts
//
//  Created by Balasaravanan Dhanwin Basil  on 29/7/24.
//

import SwiftUI

struct SearchWorkoutsView: View {
    @State private var searchText = ""
    
    let yogaPoses = [
        "Mountain Pose",
        "Child's Pose",
        "Easy Pose",
        "Corpse Pose",
        "Cat Pose",
        "Cow Pose",
        "Seated Forward Bend",
        "Happy Baby Pose",
        "Standing Forward Bend",
        "Reclined Bound Angle Pose",
        "Downward-Facing Dog",
        "Warrior I",
        "Warrior II",
        "Bridge Pose",
        "Cobra Pose",
        "Tree Pose",
        "Cat-Cow Pose",
        "Triangle Pose",
        "Extended Side Angle Pose",
        "Low Lunge",
        "Chair Pose",
        "Half Moon Pose",
        "Revolved Triangle Pose",
        "Crow Pose",
        "Plank Pose",
        "Boat Pose",
        "Camel Pose",
        "Warrior III",
        "Pigeon Pose",
        "Four-Limbed Staff Pose",
        "Headstand",
        "Forearm Stand",
        "Side Plank Pose",
        "Wheel Pose",
        "Firefly Pose",
        "Dancer Pose",
        "Eight-Angle Pose",
        "Bound Angle Pose",
        "King Pigeon Pose",
        "Handstand",
        "Scorpion Pose",
        "Peacock Pose",
        "One-Legged King Pigeon Pose II",
        "Lotus Pose",
        "Flying Crow Pose",
        "One-Handed Tree Pose",
        "Grasshopper Pose",
        "One-Handed Tiger Pose"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Yoga Poses")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("All the yoga poses coded into our AI").font(.system(size:20)).frame(maxWidth: .infinity, alignment: .leading).padding(10)
                SearchBar(text: $searchText)
                List {
                    ForEach(yogaPoses.filter { searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText) }, id: \.self) { pose in
                        Text(pose)
                    }
                }
            }
        }
        .padding()
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search Yoga Poses"
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

#Preview {
    SearchWorkoutsView()
}
