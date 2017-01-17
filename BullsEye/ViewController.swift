//
//  ViewController.swift
//  BullsEye
//
//  Created by Edy Hernandez on 8/2/16.
//  Copyright © 2016 Edy Hernandez. All rights reserved.
//

import UIKit

import QuartzCore // adds the Quartzcore animation technology framework to the app for use

class ViewController: UIViewController {
    
    var currentValue = 0 // This is a variable I created. It's initially set to 50 and will stay that way until I move the slider around. It will stay active so long as the app is running. Look up scopes for more information. Note: This used to say var currentValue: Int = 0. Same for the variable right below this one!
    
    var targetValue = 0 // This declares a new instance variable called "targetValue" to the app. It starts off as Zero (the zero is never used) and gets replaced by the random number chosen by the random generator found below in the viewDidLoad method found below.
    
    var score = 0 // This is a new instance variable that will keep track of the player's score. Swift uses something called "Type Inference" to figure out what type of data this variable should use and, since 0 is a whole number, it will figure out that score should be an integer, and therefore automatically gives it the type Int! Cool!
    
    var round = 0 // An instance variable that keeps track of what round you're in the game.
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    
    
    override func viewDidLoad() { // Any code that is placed here goes into effect when the app starts up
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal") // Sets the image for the thumb icon on the slider
        slider.setThumbImage (thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage (named: "SliderThumb-Highlighted") // Sets the image for the thumb icon on the slider when it's highlighted
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage (named: "SliderTrackLeft") { // Sets a green background to the left side of the slider
            let trackLeftResizable =
                                trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") { // Sets a gray background to the right side of the slider
            let trackRightResizable =
                                trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func showAlert() {
        
        // This is one way to calculate the difference between the current value and the target value. If it's commented out, it's because there's another algorithm active that does the same thing.
        
       /* var difference: Int
        if currentValue > targetValue {
            difference = currentValue - targetValue
        } else if targetValue > currentValue {
            difference = targetValue - currentValue
        } else {
            difference = 0
        } */
        
        // This is another algorithm that does the same thing above slightly differently.
        
        /* var difference = currentValue - targetValue
        if difference < 0 {
            difference = difference * -1
        } */
        
        // This is one more way to write the algorithm in its shortest form using the absolute value function 
        
        let difference = abs(targetValue - currentValue)
        // End algorithm examples
        // Everything listed above after the beginning of the showAlert function is actually an algorithm! Cool.
        
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points // Adds the points the player scored in the current round to the total score. This is shorthand for score = score + points
        
        // let message = "You scored \(points) points"
        
        let message = "The value of the slider is \(currentValue)"
                    + "\nThe Target value is: \(targetValue)" // The \n in this piece of code is similar to a line break in HTML!
                    + "\nThe difference is: \(difference)"
                    + "\nYou scored \(points) points!"
        
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .Alert)
        
        let action = UIAlertAction (title: "Ok", style: .Default,
                                    handler: { action in // This is a closure. It runs both the startNewRound and updateLabels methods only after the alert box after a round is over is dismissed
                                                self.startNewRound() // When using closures, you must use "self" to refer to the view controller. This is important in Swift. Otherwise, Xcode will not build my app. 
                                                self.updateLabels()
        })
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value) // lroundf rounds the number to the nearest whole number and stores it to the variable currentValue based off of slider.value
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        let transition = CATransition () // This sets up an animation using Quartzcore that crossfades from what is currently seen on screen to the changes I make in startNewGame ()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction (name:
                                                kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }
    // End Quartzcore crossfade animation code
    
    
    func startNewRound() {
        round += 1 // This increments the round label by one every time a new round starts.
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue) // Float, a number that can have digits after the decimal point. The following wouldn't work here because currentValue only accepts integers (whole numbers) and the slider number originally includes digits after the decimal point, which would display that way if I didn't tell my app to round that number to the nearest whole number: slider.value = currentValue
    }
    
    func updateLabels () { // This is a method that updatest the labels on the app
        targetLabel.text = String(targetValue) // I can also use: targetLabel.text = "\(targetValue)" and it would do the exact same thing here. It's simply a matter of preference at this point.
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }

}

