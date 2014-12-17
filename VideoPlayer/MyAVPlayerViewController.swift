//
//  MyAVPlayerViewController.swift
//  VideoPlayer
//
//  Created by Valerio Ferrucci on 17/12/14.
//  Copyright (c) 2014 Valerio Ferrucci. All rights reserved.
//

import Foundation

import AVFoundation
import AVKit

/*
AVPlayerViewController ha le funzionalità di MPMoviePlayerController più altro (vedi slide)
Solo da iOS8


SOTTOCLASSI UTILI DI AVKit

AVQueuePlayer (: AVPLayer)
serie di video
AVComposition (: AVAsset)
combino track e clip per composition, transitions, effetti etc

*/


class MyAVPlayerViewController: AVPlayerViewController {
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var hlsUrl = "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"
        var m4vUrl = "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
        var url: NSURL? = NSURL(string: m4vUrl)
        
        // player = AVPlayer(URL: url)
        
        // oppure
        let asset = AVURLAsset(URL: url, options: nil)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        
        let myView = UIView(frame: CGRectMake(60, 60, 50, 50))
        myView.backgroundColor = UIColor.redColor()
        self.contentOverlayView.addSubview(myView)
        
        /*
        
        ATTENZIONE SE FAI KVO sul AVPlayerViewController leva i controlli e fa autoplay (bug?)
        */
        
        //self.addObserver(self, forKeyPath: "readyForDisplay", options: nil, context: nil)
        
    }

    /*override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "readyForDisplay" {
            
        }
    }*/
    
    
}
