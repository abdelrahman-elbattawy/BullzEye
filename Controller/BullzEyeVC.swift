//
//  ViewController.swift
//  BullzEye
//
//  Created by Aboody on 04/06/2021.
//

import UIKit

class BullzEyeVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var targetLBLOutlet: UILabel!
    @IBOutlet weak var scoreLBLOutlet: UILabel!
    @IBOutlet weak var roundLBLOutlet: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    //MARK: - Contants
    let midValue = 50
    var round = 0
    var score = 0
    var target = 0
    var difference = 0
    var currentValue = 50
    var status: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSliderBarDesign()
        reset()
        loadData()
    }
    //MARK: - IBActions
    @IBAction func resetBtnPressed(_ sender: UIButton) {
        reset()
    }
    @IBAction func hitmeBtnPressed(_ sender: UIButton) {
        newRound()
        popAlertInfo()
    }
    @IBAction func sliderPressed(_ sender: UISlider) {
        currentValue = Int(sender.value.rounded())
    }
    
    //MARK: - Helper Functions
    func setSliderBarDesign(){
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        sliderOutlet.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlight = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        sliderOutlet.setThumbImage(thumbImageHighlight, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable  = trackLeftImage.resizableImage(withCapInsets: insets)
        sliderOutlet.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackrightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        sliderOutlet.setMaximumTrackImage(trackrightResizable, for: .normal)
    }
    func generateRanodumNumber(){
        target = Int.random(in: 2 ... 99)
        targetLBLOutlet.text = "\(target)"
    }
    func reset(){
        generateRanodumNumber()
        
        round = 1
        score = 0
        difference = 0
        currentValue = 50
        
        scoreLBLOutlet.text = "\(score)"
        roundLBLOutlet.text = "\(round)"
        sliderOutlet.value = Float(midValue)
    }
    func newRound(){
        round += 1
        
        UserDefaults.standard.set(round, forKey: "round")
        UserDefaults.standard.synchronize()
        
        roundLBLOutlet.text = "\(round)"
        sliderOutlet.value = Float(midValue)
        
        calcScore()
    }
    func calcScore(){
        difference = target > currentValue ? target - currentValue : currentValue - target
        
        if difference == 0{
            score += 200
            status = "Perfect"
        }else if difference < 3{
            score += 100
            status = "Very Good"
        }else if difference < 5{
            score += 50
            status = "Good"
        }else if difference < 10{
            score += 20
            status = "Not Bad"
        }else{
            status = "Good Luck"
        }
        
        scoreLBLOutlet.text = "\(score)"
        
        UserDefaults.standard.set(score, forKey: "score")
        UserDefaults.standard.synchronize()
    }
    func popAlertInfo(){
        let alert = UIAlertController(title: status, message: "Your Target = \(target)\nYour Current Value = \(currentValue)\nYour Difference = \(difference)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.generateRanodumNumber()
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    func loadData(){
        score = UserDefaults.standard.integer(forKey: "score")
        round = UserDefaults.standard.integer(forKey: "round")
        
        roundLBLOutlet.text = "\(round)"
        scoreLBLOutlet.text = "\(score)"
    }
}

