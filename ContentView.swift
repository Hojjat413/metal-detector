import SwiftUI
import CoreMotion

struct ContentView: View {
    @State private var metalDetectorValue: Double = 0.0
    private let motion = CMMotionManager()

    var body: some View {
        VStack {
            Text("Metal Detector: \(metalDetectorValue, specifier: "%.2f") µTesla")
                .font(.largeTitle)
            
            if metalDetectorValue > 5.0 {
                Text("Metal Detected")
                    .font(.title)
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            startUpdatingMagnetometerData()
        }
    }
    
    func startUpdatingMagnetometerData() {
        if motion.isMagnetometerAvailable {
            motion.magnetometerUpdateInterval = 0.1
            motion.startMagnetometerUpdates(to: .main) { (data, error) in
                guard let data = data, error == nil else { return }
                self.metalDetectorValue = data.magneticField.x
            }
        }
    }
}

