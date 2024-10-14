//
//  ProfileView.swift
//  pulses
//
//  Created by Vijayaganapathy Pavithraa on 2/8/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @State private var isShowingSheet = false
    
    var age = Array(1...103)
    @AppStorage("selectedAge") private var selectedAge = 30
    
    var gender = ["Male", "Female"]
    @AppStorage("selectedGender") private var selectedGender = "Male"
    
    var weight = Array(1...150)
    @AppStorage("selectedWeight") private var selectedWeight = 60
        
    var height = Array(100...200)
    @AppStorage("selectedHeight") private var selectedHeight = 160
    
    @AppStorage("name") private var name: String = "James Ong"
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var shouldPresentPhotoPicker: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack{
                        VStack {
                            Button(action: {
                                shouldPresentPhotoPicker = true;
                            }, label: {
                                if(avatarImage == nil) {
                                    Image(systemName: "person.circle").font(.system(size: 60, weight: .medium))
                                } else {
                                    avatarImage?
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(40)
                                    
                                }
                            })
                            .photosPicker(isPresented: $shouldPresentPhotoPicker,
                                          selection: $avatarItem)                    }.onChange(of: avatarItem) {
                                Task {
                                    if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                                        avatarImage = loaded
                                    } else {
                                        print("Failed")
                                    }
                                }
                            }
                        
                        VStack {
                            Text(name)
                                .font(.title)
                                .frame(maxWidth: .infinity,
                                       alignment: .leading)
                        }
                    }.listRowBackground(Color(UIColor.systemGroupedBackground))
                }
                Section{
                    VStack(alignment: .leading){
                        Text("Age")
                        Text("\(selectedAge) years old")
                            .font(.title2)
                    }
                    
                    VStack(alignment: .leading){
                        Text("Gender")
                        Text("\(selectedGender)")
                            .font(.title2)
                    }
                    
                    VStack(alignment: .leading){
                        Text("Height")
                        Text("\(selectedHeight) cm")
                            .font(.title2)
                    }
                    
                    VStack(alignment: .leading){
                        Text("Weight")
                        Text("\(selectedWeight) kg")
                            .font(.title2)
                    }
                    
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button("Edit") {
                        isShowingSheet.toggle()
                    }
                    .sheet(isPresented: $isShowingSheet,
                           onDismiss: didDismiss) {
                        VStack{
                            Text("Edit Profile")
                                .font(.title)
                                .padding()
                            Form{
                                HStack{
                                    Text("Pet name")
                                        .padding()
                                    TextField("Pet name", text: $name)
                                        .padding()
                                }
                                .cornerRadius(12)
                                
                                HStack{
                                    Picker("Age", selection: $selectedAge) {
                                        ForEach(age, id: \.self) { age in
                                            Text("\(age)")
                                        }
                                    }
                                    .padding()
                                }
                                .cornerRadius(12)
                                
                                HStack{
                                    Picker("Gender", selection: $selectedGender) {
                                        ForEach(gender, id: \.self) { gender in
                                            Text("\(gender)")
                                        }
                                    }
                                    .padding()
                                }
                                .cornerRadius(12)
                                
                                HStack{
                                    Picker("Height", selection: $selectedHeight) {
                                        ForEach(height, id: \.self) { height in
                                            Text("\(height)")
                                        }
                                    }
                                    .padding()
                                }
                                .cornerRadius(12)
                                
                                HStack{
                                    Picker("Weight", selection: $selectedWeight) {
                                        ForEach(weight, id: \.self) { weight in
                                            Text("\(weight)")
                                        }
                                    }
                                    .padding()
                                }
                                .cornerRadius(12)
                                
                                Button{
                                    isShowingSheet.toggle()
                                }label: {
                                    Text("Save Changes")
                                }
                                .buttonStyle(.borderedProminent)
                                .padding()
                                
                            }
                            .padding()
                        }
                    }
                }
            }
        }
    }
}
func didDismiss() {
    // dismisses the sheet
}

#Preview {
    ProfileView()
}
