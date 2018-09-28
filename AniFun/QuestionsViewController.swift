//
//  QuestionsViewController.swift
//  AniFun
//
//  Created by Mahima Borah on 28/09/18.
//  Copyright © 2018 Mahima Borah. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var questionsLabel: UILabel!
    
    @IBOutlet weak var q1steak: UIButton!
    @IBOutlet weak var q1fish: UIButton!
    @IBOutlet weak var q1carrots: UIButton!
    @IBOutlet weak var q1corn: UIButton!
    
    @IBOutlet weak var q2op1: UILabel!
    @IBOutlet weak var q2op2: UILabel!
    @IBOutlet weak var q2op3: UILabel!
    @IBOutlet weak var q2op4: UILabel!
    @IBOutlet weak var q2s1: UISwitch!
    @IBOutlet weak var q2s2: UISwitch!
    @IBOutlet weak var q2s3: UISwitch!
    @IBOutlet weak var q2s4: UISwitch!
    
    
    @IBOutlet weak var q2NextButton: UIButton!
    @IBOutlet weak var q3NextButton: UIButton!
    
    @IBOutlet weak var q3low: UILabel!
    @IBOutlet weak var q3high: UILabel!
    @IBOutlet weak var q3slider: UISlider!
    
    @IBOutlet weak var myProgressView: UIProgressView!
    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
            ]),
        
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
            ]),
        
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [
                    Answer(text: "😑", type: .cat),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barely notice them", type: .turtle),
                    Answer(text: "😊", type: .dog)
            ])
    ]
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func q1ButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
            case q1steak: answersChosen.append(currentAnswers[0])
            case q1fish: answersChosen.append(currentAnswers[1])
            case q1carrots: answersChosen.append(currentAnswers[2])
            case q1corn: answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func q2ButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        
        if q2s1.isOn{
            answersChosen.append(currentAnswers[0])
        }
        if q2s2.isOn{
            answersChosen.append(currentAnswers[1])
        }
        if q2s3.isOn{
            answersChosen.append(currentAnswers[2])
        }
        if q2s4.isOn{
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func q3ButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(q3slider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    
    func updateUI(){
        q1steak.isHidden = true
        q1corn.isHidden = true
        q1fish.isHidden = true
        q1carrots.isHidden = true
        q2s1.isHidden = true
        q2s2.isHidden = true
        q2s3.isHidden = true
        q2s4.isHidden = true
        q2op1.isHidden = true
        q2op2.isHidden = true
        q2op3.isHidden = true
        q2op4.isHidden = true
        q3low.isHidden = true
        q3high.isHidden = true
        q3slider.isHidden = true
        q2NextButton.isHidden = true
        q3NextButton.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionsLabel.text = currentQuestion.text
        myProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type{
        case .single:
            updateQ1(using: currentAnswers)
        case .multiple:
            updateQ2(using: currentAnswers)
        case .ranged:
            updateQ3(using: currentAnswers)
        }
    }
    
    func updateQ1(using ansers:[Answer]){
        q1steak.isHidden = false
        q1fish.isHidden = false
        q1corn.isHidden = false
        q1carrots.isHidden = false
    }
    
    func updateQ2(using answers:[Answer]){
        q2NextButton.isHidden = false
        
        q2s1.isHidden = false
        q2s2.isHidden = false
        q2s3.isHidden = false
        q2s4.isHidden = false
        q2s1.isOn = false
        q2s2.isOn = false
        q2s3.isOn = false
        q2s4.isOn = false
        
        q2op1.isHidden = false
        q2op1.text = answers[0].text
        q2op2.isHidden = false
        q2op2.text = answers[1].text
        q2op3.isHidden = false
        q2op3.text = answers[2].text
        q2op4.isHidden = false
        q2op4.text = answers[3].text
    }
    
    func updateQ3(using answers:[Answer]){
        q3NextButton.isHidden = false
        q3slider.isHidden = false
        q3slider.setValue(0.5, animated: true)
        q3low.isHidden = false
        q3high.isHidden = false        
        q3low.text = answers.first?.text
        q3high.text = answers.last?.text
    }
    
    func nextQuestion(){
        questionIndex+=1
        
        if questionIndex < questions.count{
            updateUI()
        }else{
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "resultSegue"{
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }

}
