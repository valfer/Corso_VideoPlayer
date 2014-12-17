//
//  AVPlayerViewControllerVC.swift
//  VideoPlayer
//
//  Created by Valerio Ferrucci on 17/12/14.
//  Copyright (c) 2014 Valerio Ferrucci. All rights reserved.
//

import Foundation
import AVKit


class AVPlayerViewControllerVC : UIViewController {

    @IBAction func play(sender: AnyObject) {
        
        let myVC = MyAVPlayerViewController()
        self.presentViewController(myVC, animated: true, nil)
    }
    
}
