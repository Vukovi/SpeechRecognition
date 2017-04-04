//
//  ViewController.swift
//  SpeechRecognition
//
//  Created by Vuk Knezevic on 4/4/17.
//  Copyright © 2017 Vuk Knezevic. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate { //ovaj delegat mi omogucava da implementiram metodu kojom pratim zavrsetak pustanja audio fajla

    @IBOutlet weak var indikator: UIActivityIndicatorView!
    @IBOutlet weak var ispis: UITextView!
    @IBOutlet weak var dugme: KruznoDugme!
    
    var audioPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indikator.isHidden = true
    }

    func autorizacijaGovora() {
        SFSpeechRecognizer.requestAuthorization { (status) in
            if status == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch let error as NSError {
                        print(error.debugDescription)
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print(result!.bestTranscription.formattedString)
                            self.ispis.text = result!.bestTranscription.formattedString // ovo ispisuje teks koji sam govorio telefonu
                        }
                    })
                }
            }
        }
    }
    
    
    @IBAction func klikNaDugme(_ sender: AnyObject) {
        indikator.isHidden = false
        indikator.startAnimating()
        autorizacijaGovora()
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayer.stop()
        indikator.stopAnimating()
        indikator.isHidden = true
    }

}

