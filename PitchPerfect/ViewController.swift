//
//  ViewController.swift
//  PitchPerfect
//
//  Created by JUNYEONG.YOO on 1/8/17.
//  Copyright © 2017 Boostcamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordStatusLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    @IBAction func recordButtonAction(_ sender: Any) {
        recordStatusLabel.text = "Record in Progress"
        recordButton.isEnabled = false
        stopRecordingButton.isEnabled = true
    }
    
    @IBAction func stopRecordingButtonAction(_ sender: Any) {
        recordStatusLabel.text = "Tab to Record"
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

