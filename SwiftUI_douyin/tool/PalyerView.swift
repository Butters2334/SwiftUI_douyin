//
//  PalyerView.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/22.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import AVKit
import PhotosUI
import MobileCoreServices

struct ContentView2: View {

    @State var showImagePicker: Bool = false
    @State var url: URL?

    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    withAnimation {
                        self.showImagePicker.toggle()
                    }
                }) {
                    Text("Show image picker")
                }

                PlayerContainerView(player: AVPlayer(url: url ?? URL(string: "35731289981082031.MP4")!))
            }

            if (showImagePicker) {
                ImagePicker(isShown: $showImagePicker, url: $url)
            }
        }
    }
}

struct PlayerView: UIViewRepresentable {
    let player: AVPlayer
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
        (uiView as? PlayerUIView)?.updatePlayer(player: player)
    }

    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(player: player)
    }
}

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    init(player: AVPlayer) {
        super.init(frame: .zero)

        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    func updatePlayer(player: AVPlayer) {
        self.playerLayer.player = player
    }
}

struct PlayerContainerView : View {

    @State var seekPos = 0.0

    private let player: AVPlayer
    init(player: AVPlayer) {
        self.player = player
    }
    var body: some View {
        VStack {
            PlayerView(player: player)
            PlayerControlsView(player: player)
        }
    }
}

struct PlayerControlsView : View {
    @State var playerPaused = true
    @State var seekPos = 0.0
    let player: AVPlayer
    var body: some View {
        HStack {
            Button(action: {
                self.playerPaused.toggle()
                if self.playerPaused {
                    self.player.pause()
                }
                else {
                    self.player.play()
                }
            }) {
                Image(systemName: playerPaused ? "play" : "pause")
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            }
//            Slider(value: $seekPos, from: 0, through: 1, onEditingChanged: { _ in
//                guard let item = self.player.currentItem else {
//                    return
//                }
//
//                let targetTime = self.seekPos * item.duration.seconds
//                self.player.seek(to: CMTime(seconds: targetTime, preferredTimescale: 600))
//            })
//                .padding(.trailing, 20)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var isShown: Bool
    @Binding var url: URL?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var isShown: Bool
        @Binding var url: URL?

        init(isShown: Binding<Bool>, url: Binding<URL?>) {
            _isShown = isShown
            _url = url
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
            guard let mediaType = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaType)] as? String,
                mediaType == (kUTTypeMovie as String),
                let uiURL = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaURL)] as? URL
                else { return }

            url = uiURL
            isShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, url: $url)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

#if DEBUG
struct ContentView2_Previews : PreviewProvider {
    static var previews: some View {
        ContentView2(showImagePicker: true)
    }
}
#endif
