//
//  ViewController.swift
//  retroCalculator
//
//  Created by Andrew Chng on 11/12/15.
//  Copyright © 2015 Andrew Chng. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation : String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Substract = "-"
        case Equal = "="
        case Empty = ""
    }
    
    @IBOutlet weak var outputLbl : UILabel!
    
    var btnSound : AVAudioPlayer!
    var runningNumber = ""
    var currentOperation : Operation = Operation.Empty
    var leftOperand = ""
    var rightOperand = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl  = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
         }
        }

    @IBAction func btnPressed( btn : UIButton){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation (op : Operation){
        playSound()
        
        if currentOperation !=  Operation.Empty{

            if runningNumber != ""{
                
                rightOperand = runningNumber
                runningNumber = ""
                
                if op == Operation.Divide{
                    result = "\(Double(leftOperand)! / Double(rightOperand)!)"
                }
                else if op == Operation.Multiply{
                    result = "\(Double(leftOperand)! * Double(rightOperand)!)"
                }
                else if op == Operation.Substract{
                    result = "\(Double(leftOperand)! - Double(rightOperand)!)"
                }
                else if op == Operation.Add{
                    result  = "\(Double(leftOperand)! + Double(rightOperand)!)"
                }
                
                leftOperand = result
                outputLbl.text = result
            }
            
            currentOperation  = op
        
        }
        else{
            leftOperand = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
}

