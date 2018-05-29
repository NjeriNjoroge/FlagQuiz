//
//  ViewController.swift
//  FlagQuiz
//
//  Created by Grace on 23/05/2018.
//  Copyright © 2018 Grace. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
    }

    //imported GameplayKit for randomizing the array of countries
    func askQuestion(action: UIAlertAction!) {
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        //generates a random number between 0 & 2
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        
        title = countries[correctAnswer].uppercased()
    }
   
    //the .tag is a number you can set on a uiview to uniquely identify it
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        /*
        The handler parameter is looking for a closure, which is some code that it can execute when the button is tapped. You can write custom code in there if you want, but in our case we want the game to continue when the button is tapped, so we pass in askQuestion so that iOS will call our askQuestion() method
        */
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true, completion: nil)
    }
    

}

