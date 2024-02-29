import SwiftUI
import UIKit
import AVFoundation
import AVKit

// ContentView is a SwiftUI view responsible for displaying video content.
struct ContentView: View {
    
    // State variables to manage the video URL and the presentation of the video picker.
    @State private var videoURL: URL?
    @State private var isShowingPicker = false
    
    // Body of the ContentView.
    var body: some View {
        VStack {
            // Display VideoPlayer if videoURL is not nil.
            if let url = videoURL {
                VideoPlayer(player: AVPlayer(url: url)).frame(height: 300)
            } else {
                // Button to trigger the presentation of the video picker.
                Button(action: {
                    isShowingPicker = true // Set isShowingPicker to true when button is clicked
                }) {
                    Image(systemName: "video")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            // Button to pick a video file.
            Button(action: {
                isShowingPicker = true // Set isShowingPicker to true when button is clicked
            }) {
                Text("PICK VIDEO")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        // Present the video picker as a sheet when isShowingPicker is true.
        .sheet(isPresented: $isShowingPicker) {
            SwiftUIViewVideoPicker(videoURL: $videoURL)
        }
        .padding()
    }
}
