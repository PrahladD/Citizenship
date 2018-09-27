//
//  TestController.swift
//  Citizenship
//
//  Created by Parlad Dhungana on 2018-09-12.
//  Copyright © 2018 Parlad Dhungana. All rights reserved.
//

import UIKit

class TestController: ParentController {
    
    //MARK:- IBOutlets and properties
    let backgroundColors: [UIColor] = [
        UIColor.customColor(red: 188, green: 46, blue: 157),
        UIColor.customColor(red: 247, green: 40, blue: 109),
        UIColor.customColor(red: 28, green: 27, blue: 28),
        UIColor.customColor(red: 3, green: 118, blue: 26)
    ]
    
    var questions = [Result]()
    var questionNumber: Int = 0
    var correctAnswer: String?
    var score: Int = 0
    
    var totalNumberOfQuestions: Int {
        return questions.count
       
    }
    
    let parcentage: Float = 1.0
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var trackerLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        nextQuestions()
    }
 
    //MARK:- Helpers Functions and methods
    
    override func setUpView() {
        super.setUpView()
       
    }
    
    
    fileprivate func nextQuestions(){
        let buttons = [firstButton, secondButton, thirdButton, fourthButton]
        var size: CGFloat = 0
        updateUI()
        
        if questionNumber < totalNumberOfQuestions {
            var choices = questions[questionNumber].options.shuffled()
            correctAnswer = questions[questionNumber].answer
            let question = questions[questionNumber].question
            QuestionLabel.text = question
            
            for x in 0...choices.count - 1{
                if choices[x].count < 40 {
                   size = 13
                }else {
                    size = 12.2
                }
                
                buttons[x]?.optionsButton(text: choices[x], bgColor: backgroundColors[x], size: size)
            }
        }
        
    }
    
    fileprivate func updateUI(){
       scoreLabel.text = "Score: \(score)/\(totalNumberOfQuestions)"
       trackerLabel.text = "Questions: \(questionNumber + 1)/\(totalNumberOfQuestions)"
        
       let progress = (parcentage / Float(totalNumberOfQuestions) * Float(questionNumber + 1))
        progressBar.setProgress(progress, animated: true)
     
    }
    
    
    //MARK:- IBOutlets actions
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let answer = sender.currentAttributedTitle?.string else {return}
        
        if answer == self.correctAnswer {
            score += 1
        }
        questionNumber += 1
        nextQuestions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        questions.removeAll()
        print(questions.count)
    }
    
}
