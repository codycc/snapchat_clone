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
    
        guard FIRAuth.auth()?.currentUser != nil else {
            performSegue(withIdentifier: "toLoginScreen", sender: nil)
            return
        }
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
    
    func videoRecordingComplete(_ videoURL: URL!) {
        // video is passed in through objective sample code then sent over to users vc
        performSegue(withIdentifier: "goToUsersVC", sender: ["videoURL": videoURL!])
    }
    
    func videoRecordingFailed() {
        
    }
    
    func snapshotFailed() {
        
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        performSegue(withIdentifier: "goToUsersVC", sender: ["snapshotData": snapshotData])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // if the desitination is users vc
        if let usersVC = segue.destination as? UsersVC {
            print("here is sender:\(sender!)")
            // grab the video url as sender and save as a dictionary of string and url
            if let videoDict = sender! as? Dictionary<String, URL> {
                
                // let url equal the video Url
                let url = videoDict["videoURL"]
//                print("HERE IS THE URL\(url)")
                // the constant in users vc called videoURL is now set to url
                usersVC.videoURL = url
            } else if let snapDict = sender as? Dictionary<String, Data> {
                let snapData = snapDict["snapshotData"]
                usersVC.snapData = snapData
            }
        }
    }


}

