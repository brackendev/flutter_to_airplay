//
//  FlutterAVPlayer.swift
//  flutter_to_airplay
//
//  Created by Junaid Rehmat on 22/08/2020.
//

import Foundation
import AVKit
import MediaPlayer
import Flutter

class FlutterAVPlayer: NSObject, FlutterPlatformView {
    private var _flutterAVPlayerViewController : AVPlayerViewController;

    init(frame:CGRect,
          viewIdentifier: CLongLong,
          arguments: Dictionary<String, Any>,
          binaryMessenger: FlutterBinaryMessenger) {
        _flutterAVPlayerViewController = AVPlayerViewController()
        _flutterAVPlayerViewController.viewDidLoad()
        if let urlString = arguments["url"] {
            let item = AVPlayerItem(url: URL(string: urlString as! String)!)
            _flutterAVPlayerViewController.player = AVPlayer(playerItem: item)
        } else if let fileName = arguments["file"] as? String {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            let downloadsDirectory = documentsDirectory.appendingPathComponent("Downloads")
            let url = downloadsDirectory.appendingPathComponent(fileName)
            let item = AVPlayerItem(url: url)
            _flutterAVPlayerViewController.player = AVPlayer(playerItem: item)
        }
        _flutterAVPlayerViewController.player!.play()
    }
    func view() -> UIView {
        return _flutterAVPlayerViewController.view;
    }

}
