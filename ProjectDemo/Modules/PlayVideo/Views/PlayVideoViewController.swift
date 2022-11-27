//
//  PlayVideoViewController.swift
//  ProjectDemo
//
//  Created by đạt on 26/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

final class PlayVideoViewController: BaseViewController, YTPlayerViewDelegate {

    @IBOutlet weak var playerView: YTPlayerView!
    // MARK: - Properties
	var presenter: PlayVideoPresenterInterface!
    
    var key: String? {
        if let key = payload as? String {
            return key
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        playerView.delegate = self
        playerView.load(withVideoId: key.isNil(value: ""))
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}

// MARK: - PlayVideoViewInterface
extension PlayVideoViewController: PlayVideoViewInterface {
}
