import SwiftUI
import UIKit
import AVFoundation
import AVKit

// SwiftUIViewVideoPicker is a UIViewControllerRepresentable used to pick a video from the photo library.
struct SwiftUIViewVideoPicker: UIViewControllerRepresentable {
    // Binding to manage the selected video URL.
    @Binding var videoURL: URL?
    // Environment variable to manage the presentation mode.
    @Environment(\.presentationMode) private var presentationMode
    
    // Creates and returns a coordinator object to coordinate with the UIKit view controller.
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    // Creates a UIImagePickerController instance and configures it.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator // Set the coordinator as the delegate.
        picker.sourceType = .photoLibrary // Set the source type to the photo library.
        picker.mediaTypes = ["public.movie"] // Specify media types to pick only videos.
        return picker
    }
    
    // Not used for this implementation, but required by the protocol.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update logic can be implemented here if needed.
    }
    
    // Coordinator class to handle interactions with the UIImagePickerController.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: SwiftUIViewVideoPicker
        
        // Initialize the coordinator with the parent SwiftUIViewVideoPicker instance.
        init(parent: SwiftUIViewVideoPicker) {
            self.parent = parent
        }
        
        // Called when the user finishes picking a media item.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let videoURL = info[.mediaURL] as? URL {
                parent.videoURL = videoURL // Update the parent's videoURL with the selected video's URL.
            }
            parent.presentationMode.wrappedValue.dismiss() // Dismiss the presentation mode.
        }
        
        // Called when the user cancels the picker.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss() // Dismiss the presentation mode.
        }
    }
}
