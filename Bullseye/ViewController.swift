//
//  ViewController.swift
//  Bullseye
//
//  Created by Jose on 24/06/2019.
//  Copyright © 2019 Jose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue  = 50
    var targetValue = 0
    var score = 0
    var round = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            let roundedValue = slider.value.rounded()
            currentValue = Int(roundedValue)
            startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
         let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsetsMake( 0,  14, 0,  14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
   
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        score += points
        
        let title: String
        if difference == 0{
            title = "Nice one"
            points += 100
        } else if difference < 5 {
            if difference == 1 {
                points += 50
            }
            title = "So Close"
        }else if difference < 10 {
            title = "Fairly Good my Friend"
        } else {
            title = "Not Even close"
        }
        
        
        
        
        
        
        let message = "your socre \(points) points"
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Next Challenge", style: .default, handler: {
            action in
            self.startNewRound()
        })
         alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
        
    }
    @IBAction func sliderMove(_ slider: UISlider){
        print( "the value of the slider is now: \(slider.value)")
        let roundedValue = slider.value.rounded()
        print( "The  rounded value of the slider is now: \(roundedValue)")
        currentValue = Int(roundedValue)
    }
    func startNewRound(){
        round += 1
        targetValue = Int(arc4random_uniform(100)) + 1
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    func updateLabels(){
    targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    @IBAction func startNewGame(){

        score = 0
        round = 0
        startNewRound()
    }
   
    
}
