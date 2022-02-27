//
//  AudioPlayer.swift
//  SwiftUI_AppStorage
//
//  Created by Seogun Kim on 2022/02/28.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("사운드 파일을 재생할 수 없음")
        }
    }
}
