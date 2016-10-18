//
//  ViewController.swift
//  devchatClone
//
//  Created by Cody Condon on 2016-10-14.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class CameraVC: AVCamCameraViewController, CameraVCDelegate {
    @IBOutlet weak var previewView: AVCamPreviewView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!

    override func viewDidLoad() {
        delegate = self
        // grabbing apples code to load before this view 
        _previewView = previewView
        super.viewDidLoad()
        captureModeOn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Firebase auth if current user not logged in then show login screen
      performSegue(withIdentifier: "toLoginScreen", sender: nil)
//        guard FIRAuth.auth()?.currentUser != nil else {
//            performSegue(withIdentifier: "toLoginScreen", sender: nil)
//            return
//        }
    }

    @IBAction func recordBtnPressed(_ sender: AnyObject) {
       toggleMovieRecording()
     // capturePhoto()
    }
   
    @IBAction func changeCameraBtnPressed(_ sender: AnyObject) {
       changeCamera()
    }
    
    func shouldEnableCameraUI(_ enable: Bool) {
        cameraBtn.isEnabled = enable
        print("Should enable camera UI: \(enable)")
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        recordBtn.isEnabled = enable
        print("Should enable record UI: \(enable)")
    }
    
    func recordingHasStarted() {
        print("Recording has started")
    }
    
    func canStartRecording() {
        print("Can start recording")
    }


}

