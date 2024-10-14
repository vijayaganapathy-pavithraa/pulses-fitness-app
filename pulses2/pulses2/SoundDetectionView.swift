import SwiftUI
import AVFoundation
import AudioToolbox

class AudioEngineManager: ObservableObject {
    @Published var soundLevel: Float = 0.0

    private let audioEngine = AVAudioEngine()
    private let audioSession = AVAudioSession.sharedInstance()
    private var inputNode: AVAudioInputNode?

    func startAudioEngine() {
        audioSession.requestRecordPermission { [weak self] granted in
            guard let self = self else { return }
            if granted {
                do {
                    try self.configureAudioSession()
                    try self.startEngine()
                } catch {
                    print("Error starting audio engine: \(error.localizedDescription)")
                    return
                }
                self.setupInputTap()
            } else {
                print("Microphone permission denied")
            }
        }
    }

    private func configureAudioSession() throws {
        try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    }

    private func startEngine() throws {
        inputNode = audioEngine.inputNode
        try audioEngine.start()
    }

    private func setupInputTap() {
        guard let inputNode = inputNode else { return }

        let inputFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) { [weak self] buffer, _ in
            self?.processAudioBuffer(buffer)
        }
    }

    private func processAudioBuffer(_ buffer: AVAudioPCMBuffer) {
        buffer.frameLength = 1024
        guard let channelData = buffer.floatChannelData?[0] else { return }

        var rms: Float = 0.0
        for frame in 0..<Int(buffer.frameLength) {
            let sample = channelData[frame]
            rms += sample * sample
        }
        rms = sqrt(rms / Float(buffer.frameLength))

        let avgPower = 20 * log10(rms)

        DispatchQueue.main.async { [weak self] in
            self?.soundLevel = avgPower
        }
    }

    func stopAudioEngine() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.reset()
        try? audioSession.setActive(false)
    }
}

struct SoundDetectionView: View {
    @StateObject private var audioEngineManager = AudioEngineManager()
    @State private var selectedActivity = "Action"
    let activity = ["Medium", "High", "Very High", "Disable"]

    func vibratePhone() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }

    var body: some View {
        Text("Sound Detection").font(.title) .bold().accentColor(.red).padding()
        VStack {
            Text("Sound Level:")
            Text(String(format: "%.2f dB", audioEngineManager.soundLevel))
                .font(.largeTitle)
        }
        .onAppear {
            audioEngineManager.startAudioEngine()
        }
        .onDisappear {
            audioEngineManager.stopAudioEngine()
        }
        
        Text(" ")
            .padding()
            .padding(.horizontal, 50)

        VStack {
            Text("Vibrate when sound level is:")
            Picker("Activity", selection: $selectedActivity) {
                ForEach(activity, id: \.self) { activity in
                    Text(activity)
                }
            }
            .pickerStyle(.segmented)
            .padding()
        }
        
        Text(" ")
            .padding()
            .padding(.horizontal, 25)

        VStack {
            if audioEngineManager.soundLevel > -50.0 && audioEngineManager.soundLevel < -30.0 {
                Text("Sound level is Medium.")
                    .padding()
                    .accentColor(.white)
                    .background(Color.yellow.cornerRadius(10))
                if selectedActivity == "Medium" {
                    Text("VIBRATE")
                }
            } else if audioEngineManager.soundLevel > -30.0 && audioEngineManager.soundLevel < -10.0 {
                Text("Sound level is High")
                    .padding()
                    .accentColor(.white)
                    .background(Color.orange.cornerRadius(10))
                if selectedActivity == "High" || selectedActivity == "Medium" {
                    Text("Sound Detected")
                }
            } else if audioEngineManager.soundLevel > -10.0 {
                Text("Sound level is Very High")
                    .padding()
                    .accentColor(.white)
                    .background(Color.red.cornerRadius(10))
                if selectedActivity == "Very High" || selectedActivity == "High" || selectedActivity == "Medium" {
                    Text("Sound Detected")
                }
            } else {
                Text("Sound level is Low")
                    .padding()
                    .accentColor(.white)
                    .background(Color.green.cornerRadius(10))
            }
        }
        .onChange(of: audioEngineManager.soundLevel) {
            if audioEngineManager.soundLevel > -50.0 && audioEngineManager.soundLevel < -30.0 {
                if selectedActivity == "Medium" {
                    vibratePhone()
                }
            } else if audioEngineManager.soundLevel > -30.0 && audioEngineManager.soundLevel < -10.0 {
                if selectedActivity == "High" || selectedActivity == "Medium" {
                    vibratePhone()
                }
            } else if audioEngineManager.soundLevel > -10.0 {
                if selectedActivity == "Very High" || selectedActivity == "High" || selectedActivity == "Medium" {
                    vibratePhone()
                }
            }
        }
    }
}

#Preview {
    SoundDetectionView()
}

