import SwiftUI
import UIKit
import AVFoundation
import AVKit


struct VideoPicker: UIViewControllerRepresentable {
    @Binding var videoURL: URL?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.movie"]
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: VideoPicker
        
        init(parent: VideoPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let videoURL = info[.mediaURL] as? URL {
                parent.videoURL = videoURL
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView: View {
    @State private var videoURL: URL?
    @State private var isShowingPicker = false
    
    var body: some View {
        VStack {
            if let url = videoURL {
                VideoPlayer(player: AVPlayer(url: url)).frame(height: 300)
            } else {
                Button(action: {
                    isShowingPicker = true
                }) {
                    Image(systemName: "video")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
            }
//            Text("PICK VIDEO").foregroundColor(.blue).bold().shadow(radius: 10)
            Button {
            } label: {
             Text("PICK VIDEO")
             .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
        }
        .sheet(isPresented: $isShowingPicker) {
            VideoPicker(videoURL: $videoURL)
        }
        .padding()
    }
}

