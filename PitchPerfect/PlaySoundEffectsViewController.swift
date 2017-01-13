//
//  PlaySoundEffectsViewController.swift
//  PitchPerfect
//
//  Created by JUNYEONG.YOO on 1/10/17.
//  Copyright © 2017 Boostcamp. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundEffectsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	// MARK: Properties
	
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
	
	// Properties for UIProgressView
	var duration: Double!
	var progressTimer: Timer!
	var currentProgress: Double!

	// Properties for UIPickerView
	var selectedRow: Int!
    var effectTitles = ["Choose Sound Effect", "Fast Effect", "Slow Effect", "High Pitch Effect", "Low Pitch Effect", "Echo Effect", "Reverb Effect"]
    
    enum EffectType: Int { case fast = 1, slow, highPitch, lowPitch, echo, reverb }
    
    @IBOutlet weak var effectPickerView: UIPickerView!
    @IBOutlet weak var audioControlPanel: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
	
	// MARK: Configure UIPickerView
	
	// This method returns the height of a row of the picker view.
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
	
	// This method defines when a row is selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        
        if row == 0 {
			// If an user choose no audio effect.
            audioControlPanel.isHidden = true
        } else {
			// If an user choose an audio effect.
            audioControlPanel.isHidden = false
            configureUI(.notPlaying)
        }
    }
	
	// This method returns the number of rows picker view will have.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return effectTitles.count
    }

	// This method returns the number how many components a row will have.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
	
	// This method defines the view of a row.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 30, height: 60))
        let effectImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let effectLabel = UILabel(frame: CGRect(x: 60, y: 0, width: pickerView.bounds.width - 90, height: 60))
        
        switch row {
        case EffectType.fast.rawValue:
            effectLabel.text = effectTitles[row]
            effectImageView.image = #imageLiteral(resourceName: "Fast")
            
        case EffectType.slow.rawValue:
            effectLabel.text = effectTitles[row]
            effectImageView.image = #imageLiteral(resourceName: "Slow")
            
        case EffectType.highPitch.rawValue:
            effectLabel.text = effectTitles[row]
            effectImageView.image = #imageLiteral(resourceName: "HighPitch")
            
        case EffectType.lowPitch.rawValue:
            effectLabel.text = effectTitles[row]
            effectImageView.image = #imageLiteral(resourceName: "LowPitch")
            
        case EffectType.echo.rawValue:
            effectLabel.text = effectTitles[row]
            effectImageView.image = #imageLiteral(resourceName: "Echo")
            
        case EffectType.reverb.rawValue:
            effectLabel.text = effectTitles[row]
            effectImageView.image = #imageLiteral(resourceName: "Reverb")
            
        default:
            effectLabel.text = effectTitles[row]
            effectImageView.image = nil
        }
        
        customView.addSubview(effectImageView)
        customView.addSubview(effectLabel)
        return customView
    }
	
	// MARK: IBAction methods
	
    @IBAction func actionPlayButton(_ sender: Any) {
        stopAudio()
        configureUI(.playing)
        
		switch EffectType(rawValue: selectedRow)! {
        case .fast:
            playSound(rate: 1.5)
            
        case .slow:
            playSound(rate: 0.5)
            
        case .highPitch:
            playSound(pitch: 1000)
            
        case .lowPitch:
            playSound(pitch: -1000)
            
        case .echo:
            playSound(echo: true)
            
        case .reverb:
            playSound(reverb: true)
        }
		
		startProgressView()
    }
    
    @IBAction func actionStopButton(_ sender: Any) {
        stopAudio()
    }
	
	// MARK: viewDidLoad method
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        effectPickerView.delegate = self
        effectPickerView.dataSource = self
		audioControlPanel.isHidden = true
        setupAudio()
    }

}
