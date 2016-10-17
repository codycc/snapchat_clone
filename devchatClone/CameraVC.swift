//
//  ViewController.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-14.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import AVFoundation 

class CameraVC: AVCamCameraViewController {
    @IBOutlet weak var previewView: AVCamPreviewView!

    override func viewDidLoad() {
        // grabbing apples code to load before this view 
        _previewView = previewView
        super.viewDidLoad()
        captureModeOn()
        
        
    }

    @IBAction func recordBtnPressed(_ sender: AnyObject) {
       toggleMovieRecording()
     // capturePhoto()
    }
   
    @IBAction func changeCameraBtnPressed(_ sender: AnyObject) {
       changeCamera()
    }


}

