//
//  File.swift
//  VideoPlayer
//
//  Created by Valerio Ferrucci on 17/12/14.
//  Copyright (c) 2014 Valerio Ferrucci. All rights reserved.
//

import Foundation
import UIKit

import CoreMedia
import AVFoundation

class AVPlayerVC : UIViewController {
    
    var player: AVPlayer!    // non è un UIViewController
    var playerLayer : AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var hlsUrl = "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"
        var m4vUrl = "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
        // no rtmp? vedi: http://stackoverflow.com/questions/2184671/does-the-iphone-sdk-support-playing-an-mp4-from-rtmp-stream
        // forse con librerie esterne (ffmpeg, www.ffsdk.com)
        
        var url: NSURL? = NSURL(string: m4vUrl)
        
        if let _url = url {

            playWithAVPlayer(_url)
        }
    }
    
    // AV Foundation Programming Guide
    private func playWithAVPlayer(url : NSURL) {
        
        // Il media è un AVAsset, gli elementi (metadata e tracks) del movi sono AVAssetTrack
        
        // AVPlayer non ha interfaccia, l'interfaccia è AVPlayerLayer (subclass di CALayer), non ha controls, solo visualizzazione del movie
        
        // I tempi sono misurati con CMTime
        // CMTime  value e timeScale
        
        /* metodo veloce: player = AVPlayer(URL: url) */
        
        // metodo completo
        let asset = AVURLAsset(URL: url, options: nil)
        let playerItem = AVPlayerItem(asset: asset)
        self.player = AVPlayer(playerItem: playerItem)
        
        self.playerLayer = AVPlayerLayer(player: player)
        self.playerLayer.frame = CGRectMake(10, 10, 300, 200)
        
        self.playerLayer.addObserver(self, forKeyPath: "readyForDisplay", options: nil, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "readyForDisplay" {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.playerLayer.removeObserver(self, forKeyPath: "readyForDisplay")
                self.view.layer.addSublayer(self.playerLayer)
                
            })
        }
    }
    
    @IBAction func start(sender: AnyObject) {
        
        let rate = player.rate
        if rate < 0.01 {
            self.player.rate = 1
        } else {
            self.player.rate = 0
        }
        
    }

}