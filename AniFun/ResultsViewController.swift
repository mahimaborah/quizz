//
//  ResultsViewController.swift
//  AniFun
//
//  Created by Mahima Borah on 28/09/18.
//  Copyright © 2018 Mahima Borah. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultsAnswerLabel: UILabel!
    @IBOutlet weak var resultsDef: UITextView!
    
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculateResult()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateResult(){
        var freqOfAnswers:[AnimalType:Int] = [:]
        let responseTypes = responses.map {$0.type}
        
        for response in responseTypes{
            freqOfAnswers[response] = (freqOfAnswers[response] ?? 0) + 1
        }
        
        let mostCommonAnswer = freqOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        
        resultsAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultsDef.text = mostCommonAnswer.definition
    }

}
