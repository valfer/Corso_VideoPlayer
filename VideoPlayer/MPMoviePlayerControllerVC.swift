//
//  MPMoviePlayer.swift
//  VideoPlayer
//
//  Created by Valerio Ferrucci on 17/12/14.
//  Copyright (c) 2014 Valerio Ferrucci. All rights reserved.
//

import Foundation
import UIKit

import MediaPlayer

class MPMoviePlayerControllerVC : UIViewController {
    
    var moviePlayer: MPMoviePlayerController!    // non è un UIViewController
    
    var playing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviePlayer = MPMoviePlayerController()

        // inizializzaimo la sua view
        moviePlayer.view.frame = CGRect(x: 20, y: 100, width: 200, height: 150)
        
        // la aggiungiamo
        self.view.addSubview(moviePlayer.view)
        
        // la background view
        moviePlayer.backgroundView.backgroundColor = UIColor.redColor()

        // parte full screen?
        // moviePlayer.fullscreen = true
        
        // controlli embedded nel player
        moviePlayer.controlStyle = MPMovieControlStyle.Embedded
        
        // autoplay?
        moviePlayer.shouldAutoplay = true // default true
        
    }

    @IBAction func play(sender: AnyObject) {
        
        var hlsUrl = "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"
        var m4vUrl = "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
        // no rtmp? vedi: http://stackoverflow.com/questions/2184671/does-the-iphone-sdk-support-playing-an-mp4-from-rtmp-stream
        // forse con librerie esterne (ffmpeg, www.ffsdk.com)
        
        var url: NSURL? = NSURL(string: hlsUrl)
        
        if let _url = url {
            
            if playing {
                playing = false
                moviePlayer.stop()
            } else {
                playing = true
                playWithMPMoviePlayerController(_url)
            }
        }
    }
    
    func playWithMPMoviePlayerController(url : NSURL) {
        
        // diamo la content url
        moviePlayer.contentURL = url
        
        // chiamato da play, ma così evitiamo delay al play
        moviePlayer.prepareToPlay()
        
        // per sapere quando il video è pronto per il play mi devo registrare alla notification
        MPMoviePlayerReadyForDisplayDidChangeNotification
        
        // il video è scalato
        moviePlayer.scalingMode = .AspectFit    // default
        
        // per sapere quando è nota la dimensione (per dimensionare la view prima della addSubView) mi registro a
        MPMovieNaturalSizeAvailableNotification
        // e qui posso leggere la CGSize
        // moviePlayer.naturalSize
        
        // per andare programmaticamente in full screen
        // moviePlayer.setFullscreen(true, animated: true)
        
        // moviePlayer.repeatMode = true
        // moviePlayer.duration
        
        // questi sono NSTimeInterval
        moviePlayer.initialPlaybackTime = 0
        moviePlayer.endPlaybackTime = 20
        
        // play pause stop (MPMediaPlayback protocol)
        // moviePlayer.currentPlaybackRate
        // moviePlayer.currentPlaybackTime
        
        // notification per sapere per il corrente playback state
        MPMoviePlayerPlaybackStateDidChangeNotification
        moviePlayer.playbackState   // torna MPMoviePlaybackState
        
        // se carico da internet posso sapere se cambia il load state
        MPMoviePlayerLoadStateDidChangeNotification
        // moviePlayer.loadState   // struct MPMovieLoadState
        
        // possiamo avere solo un MPMoviePlayerController alla volta nella nostra interfaccia
        
        // view controller che gestisce per noi il movie (presented modally)
        // MPMoviePlayerViewController
        
        // interfaccia per editare il video (presented) (è un UINavigationController)
        // UIVideoEditorController
    }

}