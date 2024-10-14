//
//  ContentView.swift
//  imageRecongition
//
//  Created by Vijayaganapathy Pavithraa on 16/7/24.
//

import SwiftUI
struct AccuracyCheckView: View {
    @State private var image: UIImage?
    @State private var label: String = "Select Image"
    @State private var isImagePickerPresented = false
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
        "Firefly Pose",
        "One-Handed Tree Pose",
        "Grasshopper Pose",
        "One-Handed Tiger Pose"
    ]
    
    @State private var selectedColor = "Mountain Pose"
    @State var resultsSheetShown = false
    
    @State var yogaComment = 15 //SCORE VALUE (wowsers)
    
    var body: some View {
        Spacer().frame(height:50)
        Text("Accuracy Page").font(.title).font(.system(size:90)).bold()
        
        NavigationStack{
            VStack {
                VStack{
                    Text(" ").padding(20)
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .padding()
                    } else {
                        Button {
                            self.isImagePickerPresented = true
                        }label: {
                            Text("Select an Image").accentColor(.white)
                                .bold()
                                .padding(20)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding()
                        .sheet(isPresented: $isImagePickerPresented) {
                            // call your Model ML
                            ImagePicker(selectedImage: self.$image, label: self.$label)
                        }
                    }
                }
                

                VStack{
                    Text("What pose did you do?")
                    Picker("Please choose a pose", selection: $selectedColor) {
                        ForEach(yogaPoses, id: \.self) {
                            Text($0)
                        }
                    }
                }.padding(10)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                Text(" ").padding(5)
                Button {
                    if selectedColor == label{
                        yogaComment = 100
                    }else{
                        yogaComment = 0
                    }
                    resultsSheetShown = true
                }label: {
                    Text("Verify your workout")
                        .accentColor(.white)
                        .bold()
                        .padding(10)
                        .background(Color.green)
                        .cornerRadius(15)
                }
            }
            .padding()
            .sheet(isPresented: $resultsSheetShown){
                Text("Results").bold().underline().font(.title)
                Spacer().frame(height:60)
                Text("Your pose is").font(.system(size: 20))
                if (yogaComment < 30){
                    Text("\(yogaComment)%").bold().font(.system(size: 30)).foregroundColor(.red)
                }else if (yogaComment > 30 && yogaComment < 75){
                    Text("\(yogaComment)%").bold().font(.system(size: 30)).foregroundColor(.yellow)
                }else{
                    Text("\(yogaComment)%").bold().font(.system(size: 30)).foregroundColor(.green)
                }
                Text("accurate").font(.system(size: 20))
                
                Spacer().frame(height:40)
                
                if yogaComment == 100{
                    Text("Amazing! A perfect score").font(.system(size: 25))
                }else if (yogaComment < 30){
                    Text("You could improve on it! Try harder!").font(.system(size: 25))
                }else if (yogaComment > 30 && yogaComment < 75){
                    Text("Good job, but you can do better!").font(.system(size: 25))
                }else if (yogaComment > 75 && yogaComment < 100){
                    Text("Wow! You did really well! 👏👏👏").font(.system(size: 25))
                }
                
            }
        }
    }
    
}
#Preview {
    AccuracyCheckView()
}
