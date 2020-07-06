//
//  ViewController.swift
//  Zing Demo
//
//  Created by Steve Sheets on 7/5/20.
//  Copyright © 2020 Steve Sheets. All rights reserved.
//

import UIKit
import ZingKit

/// Demo view controller for ZingLab. The View Controller has 3 views is animated up and down on
/// the screen, as well as a Animate and Cancel button.
class ViewController: UIViewController {
    
    // Three views to animate
    
    @IBOutlet weak var redBox: UIView!
    
    @IBOutlet weak var greenBox: UIView!
    
    @IBOutlet weak var blueBox: UIView!
    
    // button to press to start animation
    
    @IBOutlet weak var animateButton: UIButton!
    
    // button to press to start animation
    
    @IBOutlet weak var cancelButton: UIButton!
    
    // Animation sequence to create
    
    var myAnimation: Zing?
    
    // On start
    
    override func viewDidLoad() {
        
        // Get initial position of all the views and offeset positions to move them to
        
        let redPos = redBox.center
        var redOff = redPos
        redOff.y += 200
        
        let greenPos = greenBox.center
        var greenOff = greenPos
        greenOff.y += 200
        
        let bluePos = blueBox.center
        var blueOff = bluePos
        blueOff.y += 200
        
        // Get the rotation transformation
        
        let angleNorm = self.redBox.transform
        let angleRotate90 = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        let angleRotate180 = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        
        // Create a zing the quickly moves the view down (while rotating) and back, but do not start it.
        
        let subZing = Zing.start().thenAnimate(duration: 0.25) {
            self.redBox.center = redOff
            self.greenBox.center = greenOff
            self.blueBox.center = blueOff
            
            self.redBox.transform = angleRotate90
            self.greenBox.transform = angleRotate90
            self.blueBox.transform = angleRotate90
            }
            .thenAnimate(duration: 0.25) {
                self.redBox.center = redPos
                self.greenBox.center = greenPos
                self.blueBox.center = bluePos
                
                self.redBox.transform = angleRotate180
                self.greenBox.transform = angleRotate180
                self.blueBox.transform = angleRotate180
            }
            .withAction() {
                self.redBox.transform = angleNorm
                self.greenBox.transform = angleNorm
                self.blueBox.transform = angleNorm
        }
        
        
        // Create the animation with name "Bouncing"
        
        myAnimation = Zing.start(title: "Bouncing")
            
            // Copy the previous zing in at this point
            
            .splice(zing: subZing)
            
            // delay 1/5 of a second
            
            .thenDelay(duration: 0.2)
            
            // Move first view (but continue on)
            
            .withAnimate(duration: 1.0) { self.redBox.center = redOff }
            
            // delay 1/10 of a second
            
            .thenDelay(duration: 0.1)
            
            // Move second view (but continue on)
            
            .withAnimate(duration: 1.0) { self.greenBox.center = greenOff }
            
            // delay 1/10 of a second
            
            .thenDelay(duration: 0.1)
            
            // Move third view, but wait until it's animation is done
            
            .thenAnimate(duration: 1.0) { self.blueBox.center = blueOff }
            
            // delay 1/2 of a second
            
            .thenDelay(duration: 0.5)
            
            // Do same sequence, but going up
            .withAnimate(duration: 1.0) { self.redBox.center = redPos }
            .thenDelay(duration: 0.1)
            .withAnimate(duration: 1.0) { self.greenBox.center = greenPos }
            .thenDelay(duration: 0.1)
            .thenAnimate(duration: 1.0) { self.blueBox.center = bluePos }
            
            // Copy the previous zing in again at this point
            
            .splice(zing: subZing)
            
            // delay 1/5 of a second
            
            .thenDelay(duration: 0.2)
            
            // Animate views 1, 2 & 3, each waiting until previous view animation is done
            .thenAnimate(duration: 1.0) { self.redBox.center = redOff }
            .thenAnimate(duration: 1.0) { self.greenBox.center = greenOff }
            .thenAnimate(duration: 1.0) { self.blueBox.center = blueOff }
            
            // delay 1/2 of a second
            
            .thenDelay(duration: 0.5)
            
            // Do same sequence, but going up
            
            .thenAnimate(duration: 1.0) { self.redBox.center = redPos }
            .thenAnimate(duration: 1.0) { self.greenBox.center = greenPos }
            .thenAnimate(duration: 1.0) { self.blueBox.center = bluePos }
            
            // Set the animation to loop forever (who canceled)
            
            .autoloop()
            
            // Set animation to reset state if canceled
            
            .onCancel {
                self.redBox.center = redPos
                self.greenBox.center = greenPos
                self.blueBox.center = bluePos
                
                self.redBox.transform = angleNorm
                self.greenBox.transform = angleNorm
                self.blueBox.transform = angleNorm
        }
        
        // Animation is not started at this point, but stored.
    }
    
    // Press animate button invokes animation
    
    @IBAction func animateAction(_ sender: Any) {
        myAnimation?.execute()
    }
    
    // Press Cancel button invokes cancel of animation with name "Bouncing"
    
    @IBAction func cancelAction(_ sender: Any) {
        Zing.cancel(title: "Bouncing")
    }
    
}
