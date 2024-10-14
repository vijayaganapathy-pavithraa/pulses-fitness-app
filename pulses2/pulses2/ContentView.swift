//
//  HomeView.swift
//  pulses
//
//  Created by Vijayaganapathy Pavithraa on 29/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var alertItem: String?
    var body: some View {
        
        TabView {
            NavigationStack {
                Text("")
                    .toolbar {
                        ToolbarItem() {
                            NavigationLink{
                                ProfileView()
                            }label:{
                                Image(systemName: "gear")
                            }
                                
                        }
                    }
                Grid(alignment: .top){
                    GridRow {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.bluePulses)
                                .frame(width: 180, height: 180)
                            NavigationLink{
                                AccuracyCheckView()
                            }label:{
                                VStack{
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.custom("SFPro",fixedSize: 75))
                                        .foregroundStyle(.bluePulsesText)
                                    Text("Accuracy Check")
                                }
                            }
                            .padding(1.5)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.purplePulses)
                                .frame(width: 180, height: 180)
                            NavigationLink{
                                WorkoutPlanView()
                            }label:{
                                VStack{
                                    Image(systemName: "figure.yoga")
                                        .font(.custom("SFPro",fixedSize: 75))
                                        .foregroundStyle(.purplePulsesText)
                                    Text("Workouts for you")
                                        .foregroundStyle(.purple)
                                }
                            }
                            .padding(1.5)
                        }
                    }
                    GridRow{
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.purple2Pulses)
                                .frame(width: 180, height: 180)
                            NavigationLink{
                                SoundDetectionView()

                            }label:{
                                VStack{
                                    Image(systemName: "ear.badge.waveform")
                                        .font(.custom("SFPro",fixedSize: 75))
                                        .foregroundStyle(.purple2PulsesText)
                                    Text("Sound Detection")
                                        .foregroundStyle(.purple)
                                }
                            }
                            .padding(1.5)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.blue2Pulses)
                                .frame(width: 180, height: 180)
                            NavigationLink{
                                SearchWorkoutsView()
                            }label:{
                                VStack{
                                    Image(systemName: "magnifyingglass")
                                        .font(.custom("SFPro",fixedSize: 75))
                                        .foregroundStyle(.blue2PulsesText)
                                    Text("Yoga Poses")
                                        .foregroundStyle(.blue2PulsesText)
                                }
                            }
                            .padding(1.5)
                        }
                        
                        
                    }
                    .navigationTitle("Home")
                }
                Spacer()
            }

        }
    }
}


#Preview {
    ContentView()
}
