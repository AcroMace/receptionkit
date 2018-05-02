//
//  DoorBell.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2018-05-02.
//  Copyright © 2018 Andy Cho. All rights reserved.
//

import AVFoundation

class DoorBell {
    var player: AVAudioPlayer?

    init() {
        guard let url = Bundle.main.url(forResource: "doorbell", withExtension: "mp3") else {
            Logger.error("Could not locate the doorbell MP3 file")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        } catch let error {
            Logger.error("Could not instantiate AVAudioPlayer")
            Logger.error(error.localizedDescription)
        }
    }

    func play() {
        if Config.General.PlayDoorbell {
            player?.play()
        }
    }
}
