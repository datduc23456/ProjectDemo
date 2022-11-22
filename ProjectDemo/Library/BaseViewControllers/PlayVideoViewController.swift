//
//  PlayVideoViewController.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 22/11/2022.
//

import UIKit
import youtube_ios_player_helper

class PlayVideoViewController: UIViewController, YTPlayerViewDelegate {
    @IBOutlet weak var playerView: YTPlayerView!
//    var playerController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let player = AVPlayer(url: URL(string: "https://youtu.be/_XkUdr0EDwk")!)
//        playerController.view.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
//        playerController.player = player
//        playerController.showsPlaybackControls = true
//        playerController.allowsPictureInPicturePlayback = true
//        playerController.delegate = self
//        playerController.player?.play()
//        self.view.addSubview(playerController.view)
//        self.present(playerController, animated: true)
        playerView.delegate = self
        playerView.load(withVideoId: "_XkUdr0EDwk")
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
