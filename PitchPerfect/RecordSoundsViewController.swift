//
//  ViewController.swift
//  PitchPerfect
//
//  Created by JUNYEONG.YOO on 1/8/17.
//  Copyright © 2017 Boostcamp. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordStatusLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    @IBAction func recordButtonAction(_ sender: Any) {
        recordStatusLabel.text = "Recording in Progress"
        recordButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        // An audio session is the intermediary between your app and iOS used to configure your app’s audio behavior.
        let session = AVAudioSession.sharedInstance()
        
        // AVAudioSessionCategoryPlayAndRecord is the category for recording (input) and playback (output) of audio, 
        // such as for a VoIP (Voice over Internet Protocol) app.
        // AVAudioSessionCategoryOptions.defaultToSpeaker routes audio from the session to the built-in speaker by default.
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true  // Why metering is on? Normally it is set to off because it uses resources.
        audioRecorder.prepareToRecord()         // Creates an audio file and prepares the system for recording.
        audioRecorder.record()                  // Starts or resumes recording.
    }
    
    @IBAction func stopRecordingButtonAction(_ sender: Any) {
        recordStatusLabel.text = "Tab to Record"
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
			// When recording process is finished successfully, perform "PlaybackSegue" segue to playback effected audio.
            performSegue(withIdentifier: "PlaybackSegue", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaybackSegue" {
            let playSoundsVC = segue.destination as! PlaySoundEffectsViewController
            let recordedAudioURL = sender as! URL
			// Send the URL of the recorded audio file to PlaySoundEffectsViewController for handling this file.
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }
}

