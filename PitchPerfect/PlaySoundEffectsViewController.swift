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
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    var effectTitles = ["Choose Sound Effect", "Fast Effect", "Slow Effect", "High Pitch Effect", "Low Pitch Effect", "Echo Effect", "Reverb Effect"]
    
    enum EffectType: Int { case fast = 1, slow, highPitch, lowPitch, echo, reverb }
    
    @IBOutlet weak var effectPickerView: UIPickerView!
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stopAudio()
        
        switch row {
        case EffectType.fast.rawValue:
            playSound(rate: 1.5)
            
        case EffectType.slow.rawValue:
            playSound(rate: 0.5)
            
        case EffectType.highPitch.rawValue:
            playSound(pitch: 1000)
            
        case EffectType.lowPitch.rawValue:
            playSound(pitch: -1000)
            
        case EffectType.echo.rawValue:
            playSound(echo: true)
            
        case EffectType.reverb.rawValue:
            playSound(reverb: true)
            
        default:
//            configureUI(.notPlaying)
            print("default row")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return effectTitles.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        effectPickerView.delegate = self
        effectPickerView.dataSource = self
        setupAudio()
    }

}
