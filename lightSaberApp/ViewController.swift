//
//  ViewController.swift
//  lightSaberApp
//
//  Created by Charlie Trenholm on 11/1/18.
//  Copyright © 2018 team name: String. All rights reserved.
//

import UIKit
import AVFoundation

var lightSaberIsOn = false
var motionAudioFlag = true
var backgroundColor = UIColor.black
var kyloRen = false

var igniteAudio = AVAudioPlayer()
var offAudio = AVAudioPlayer()
var humAudio = AVAudioPlayer()
var swing1Audio = AVAudioPlayer()
var swing2Audio = AVAudioPlayer()
var swing3Audio = AVAudioPlayer()
var swing4Audio = AVAudioPlayer()
var strike1Audio = AVAudioPlayer()
var strike2Audio = AVAudioPlayer()
var strike3Audio = AVAudioPlayer()
var strike4Audio = AVAudioPlayer()
var strike5Audio = AVAudioPlayer()

class ViewController: UIViewController {
    @IBOutlet weak var maceWinduOutlet: UIButton!
    @IBOutlet weak var obiWanKenobiOutlet: UIButton!
    @IBOutlet weak var lukeSkywalkerOutlet: UIButton!
    @IBOutlet weak var kyloRenOutlet: UIButton!
    @IBOutlet weak var kyloBladeImage: UIImageView!
    @IBOutlet weak var leftBladeCover: UIImageView!
    @IBOutlet weak var rightBladeCover: UIImageView!
    @IBOutlet var kyloBladeCovers: [UIImageView]!
    
    
    @IBOutlet var allJediButtons: [UIButton]!
    

    @IBOutlet weak var handleImage: UIImageView!
    @IBOutlet weak var bladeImage: UIImageView!
    @IBOutlet weak var bladeCover: UIImageView!
    @IBOutlet weak var backgroundFlashColor: UIImageView!
    
    func kyloSideBlades() {
        if lightSaberIsOn == true && kyloRen == true {
            for asset in kyloBladeCovers {
                if asset.isHidden == true {
                    asset.isHidden = false
                }
            }
            self.leftBladeCover.center.x -= self.view.bounds.width
            self.rightBladeCover.center.x += self.view.bounds.width
            for asset in kyloBladeCovers {
                asset.isHidden = false
            }
        } else if lightSaberIsOn == true && kyloRen == false {
            self.leftBladeCover.center.x += self.view.bounds.width
            self.rightBladeCover.center.x -= self.view.bounds.width
            for asset in kyloBladeCovers {
                asset.isHidden = true
            }
        }
    }
    
    func kyloActivated() {
        self.leftBladeCover.center.x += self.view.bounds.width
        self.rightBladeCover.center.x -= self.view.bounds.width
    }
    
    
    @IBAction func lightSaberChoice(_ sender: UIButton) {
        handleImage.isHidden = false
        if sender.tag == 1{
            if kyloRen == true {
                kyloRen = false
                kyloSideBlades()
            }
            handleImage.image = UIImage(named: "maceWinduLightSaber")
            bladeImage.image = UIImage(named: "maceWinduIgnited3")
            backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.85, alpha: 1.0)
        }
        else if sender.tag == 2{
            if kyloRen == true {
                kyloRen = false
                kyloSideBlades()
            }
            handleImage.image = UIImage(named: "anakinLightSaber")
            bladeImage.image = UIImage(named: "anakinIgnited3")
            backgroundColor = UIColor(red: 0.9, green: 0.0, blue: 0.2, alpha: 1.0)
        }
        else if sender.tag == 3 {
            if kyloRen == true {
                kyloRen = false
                kyloSideBlades()
            }
            handleImage.image = UIImage(named: "obiWanLightSaber")
            bladeImage.image = UIImage(named: "obiWanIgnited3")
            backgroundColor = UIColor(red: 0.0, green: 0.2, blue: 0.8, alpha: 1.0)
        }
        else {
            if kyloRen == false {
                kyloRen = true
                for asset in kyloBladeCovers {
                    if asset.isHidden == true {
                        asset.isHidden = false
                    }
                }
                kyloSideBlades()
            }
            handleImage.image = UIImage(named: "kyloRenLightSaber")
            bladeImage.image = UIImage(named: "anakinIgnited3")
            kyloBladeImage.image = UIImage(named: "kyloRenIgnited")
            for cover in kyloBladeCovers{
                cover.backgroundColor = UIColor.black
            }
            backgroundColor = UIColor(red: 0.9, green: 0.0, blue: 0.2, alpha: 1.0)
        }
    }

    @IBAction func lightSaberDidIgnite(_ sender: Any) {
        if lightSaberIsOn == false {
            lightSaberIsOn = true
            igniteAudio.play()
            idleHum()
            backgroundFlashColor.backgroundColor = backgroundColor
            backgroundFlashColor.isHidden = false
            UIView.animate(withDuration: 0.2) {
                self.bladeCover.center.y -= self.view.bounds.height
                self.backgroundFlashColor.backgroundColor = backgroundColor.withAlphaComponent(0.4)
                if kyloRen == true {
                    self.kyloActivated()
                    for asset in self.kyloBladeCovers {
                        asset.backgroundColor = self.backgroundFlashColor.backgroundColor
                    }
                    self.kyloBladeImage.backgroundColor = UIColor.clear
                }
            }
        } else {
            lightSaberIsOn = false
            for asset in kyloBladeCovers {
                asset.isHidden = true
            }
            humAudio.stop()
            offAudio.play()
            UIView.animate(withDuration: 0.2) {
                self.backgroundFlashColor.backgroundColor = self.backgroundFlashColor.backgroundColor!.withAlphaComponent(1.0)
                self.bladeCover.backgroundColor = self.backgroundFlashColor.backgroundColor
                self.bladeCover.center.y += self.view.bounds.height
            }
            self.bladeCover.backgroundColor = UIColor.black
            self.backgroundFlashColor.isHidden = true
        }
        
    }
    
    func idleHum() {
        humAudio.numberOfLoops = -1
        humAudio.play()
    }
    
    func swingAudio() {
        if lightSaberIsOn == true && motionAudioFlag == true {
            pauseMotionAudio()
            let rand = Int.random(in: 1...4)
            if rand == 1 {
                swing1Audio.play()
            } else if rand == 2 {
                swing2Audio.play()
            } else if rand == 3 {
                swing3Audio.play()
            } else {
                swing4Audio.play()
            }
        }
    }
    
    func strikeAudio() {
        if lightSaberIsOn == true && motionAudioFlag == true {
            pauseMotionAudio()
            let rand = Int.random(in: 1...5)
            if rand == 1 {
                strike1Audio.play()
            } else if rand == 2 {
                strike2Audio.play()
            } else if rand == 3 {
                strike3Audio.play()
            } else if rand == 4 {
                strike4Audio.play()
            } else {
                strike5Audio.play()
            }
        }
    }
    
    func pauseMotionAudio() {
        motionAudioFlag = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            motionAudioFlag = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Instantiate graphical elements:
        lightSaberIsOn = false
        print("Lightsabre is off")
        
//        leftKyloBladeImage.layer.zPosition = 0
//        rightKyloBladeImage.layer.zPosition = 0
        
        
        kyloBladeImage.layer.zPosition = 0
        leftBladeCover.layer.zPosition = 1
        rightBladeCover.layer.zPosition = 1
        handleImage.isHidden = true
        bladeImage.layer.zPosition = 0
        bladeCover.layer.zPosition = 1
        handleImage.layer.zPosition = 2
        
        bladeCover.image = UIImage(named: "black")
        for button in allJediButtons {
            button.layer.cornerRadius = 25
        }
        backgroundFlashColor.isHidden = true
        
        //instantiate audio elements:
        let igniteAudioPath = Bundle.main.path(forResource: "ignite", ofType: "mp3")
        do {
            igniteAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: igniteAudioPath!))
        } catch {
            print(error)
        }
        
        
        let offAudioPath = Bundle.main.path(forResource: "off", ofType: "mp3")
        do {
            offAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: offAudioPath!))
        } catch {
            print(error)
        }
        
        let humAudioPath = Bundle.main.path(forResource: "hum", ofType: "mp3")
        do {
            humAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: humAudioPath!))
        } catch {
            print(error)
        }
        
        let swing1AudioPath = Bundle.main.path(forResource: "swing1", ofType: "mp3")
        do {
            swing1Audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: swing1AudioPath!))
        } catch {
            print(error)
        }
        
        let swing2AudioPath = Bundle.main.path(forResource: "swing2", ofType: "mp3")
        do {
            swing2Audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: swing2AudioPath!))
        } catch {
            print(error)
        }
        
        let swing3AudioPath = Bundle.main.path(forResource: "swing3", ofType: "mp3")
        do {
            swing3Audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: swing3AudioPath!))
        } catch {
            print(error)
        }
        
        let swing4AudioPath = Bundle.main.path(forResource: "swing4", ofType: "mp3")
        do {
            swing4Audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: swing4AudioPath!))
        } catch {
            print(error)
        }
        
        let strike1AudioPath = Bundle.main.path(forResource: "strike1", ofType: "mp3")
        do {
            strike1Audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: strike1AudioPath!))
        } catch {
            print(error)
        }
        
        let strike2AudioPath = Bundle.main.path(forResource: "strike2", ofType: "mp3")
        do {
            strike2Audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: strike2AudioPath!))
        } catch {
            print(error)
        }
        
        let strike3AudioPath = Bundle.main.path(forResource: "strike3", ofType: "mp3")
        do {
            strike3Audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: strike3AudioPath!))
        } catch {
            print(error)
        }
        
        let strike4AudioPath = Bundle.main.path(forResource: "strike4", ofType: "mp3")
        do {
            strike4Audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: strike4AudioPath!))
        } catch {
            print(error)
        }
        
        let strike5AudioPath = Bundle.main.path(forResource: "strike5", ofType: "mp3")
        do {
            strike5Audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: strike5AudioPath!))
        } catch {
            print(error)
        }
    }


}
