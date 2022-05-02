//
//  SecondViewController.swift
//  Stress analyzer
//
//  Created by Sonia Soyeon Lee on 4/25/22.
//
import SwiftUI
import Foundation
import UIKit

class SecondViewController: UIViewController {

    ///DUMMY DATA
    var studentNum: String?
    var surveyQuestion: String?
    //var surveyResponse: String?
    var currentIndex: Int = 1
    
    let question1 = Question(id: 1, shortWording: "feeling okay?", fullWording: "Are you feeling okay today?")
    let question2 = Question(id: 2, shortWording: "feeling down?", fullWording: "Are you feeling down today?")
    let question3 = Question(id: 3, shortWording: "feeling accomplished?", fullWording: "Are you feeling accomplished today?")
    let question4 = Question(id: 4, shortWording: "feeling sick?", fullWording: "Are you feeling sick today?")
    
    let answer1 = Answer(id: 1, label: "No", value: 1).self
    let answer2 = Answer(id: 2, label: "Yes", value: 2).self
    let answer3 = Answer(id: 3, label: "no answer", value: 2).self
    
    var survey = Survey(id: 1, name: "temp", group: "I feel ___", questions: [:], answers: [:])
    var surveyResponse = SurveyResponse(uid: "shawn", surveyID: 1, responseType: "new", responses: [1: nil, 2: 2])
    //let surveyResponse2 = SurveyResponse(uid: "shawn", surveyID: 1, responseType: "new", responses: [1: nil, 2: 2])
    
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var questionDisplayLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    @IBAction func prevQButton(_ sender: Any) {
        if currentIndex > 1 {
            currentIndex -= 1
        }
        loadText(index: currentIndex)
    }
    @IBAction func nextQButton(_ sender: Any) {
        currentIndex += 1
        loadText(index: currentIndex)
    }
    @IBAction func insertButton(_ sender: Any) {
        noButton.isHidden = false
        yesButton.isHidden = false
    }
    @IBAction func deleteButton(_ sender: Any) {
        //survey.answers.removeValue(forKey: currentIndex)
        surveyResponse.responses.removeValue(forKey: currentIndex)
        loadText(index: currentIndex)
    }
    
    @IBAction func yesAnswerButton(_ sender: Any) {
        surveyResponse.responses[currentIndex] = 2
        noButton.isHidden = true
        yesButton.isHidden = true
        loadText(index: currentIndex)
    }
    
    @IBAction func noAnswerButton(_ sender: Any) {
        surveyResponse.responses[currentIndex] = 1
        noButton.isHidden = true
        yesButton.isHidden = true
        loadText(index: currentIndex)
    }
    
    func retrieveUserData() {       //--------✳️✳️------change this---------✳️✳️--------
        
        //make api call here: server data->surveyResponse
        var questions = [Question]()
        var answers = [Answer]()
        //populate questions & answers
        
        survey = Survey(id: 1, name: "Big Five", group: "I feel ___", questions: [1: question1, 2: question2, 3: question3, 4: question4], answers: [1: answer1, 2: answer2, 3: answer3])
        
        //new call after questions & answers are populated:
        /*
         survey = Survey(id: 1, name: "Big Five", group: "I feel ___", questions: [:], answers: [:])
        
        for q in questions {
            survey.questions = [q.id: q]
        }
        for a in answers {
            survey.answers = [a.id: a]
        }
        */
        
    }
    
    override func viewDidLoad() {
        noButton.isHidden = true
        yesButton.isHidden = true
        super.viewDidLoad()
        retrieveUserData()
        loadText(index: currentIndex)
    }
    func loadText(index: Int) {
        
        if surveyResponse.uid != nil {
            studentLabel.text = surveyResponse.uid
        }
        
        questionDisplayLabel.text = survey.questions[index]?.fullWording
        
        if surveyResponse != nil {
            responseLabel.text = survey.answers[index]?.label
            responseLabel.text = survey.answers[(surveyResponse.responses[index] ?? 3) ?? 3]?.label
        }
    }
    
}



//    @IBAction func updateButton(_ sender: Any) {
//        var body: some View {
//            Menu("Update") {
//                Button("Disagree Strongly", action: disagreeStrongly)
//                Button("Disagree a Little", action: disagreeLittle)
//                Button("Neither Agree or Disagree", action: neitherDisagreeAgree)
//                Button("Agree a Little", action: agreeLittle)
//                Button("Disagree Strongly", action: agreeStrongly)
//            } primaryAction: {
//                    justDoIt()
//            }
//
//        func disagreeStrongly() { }
//        func disagreeLittle() { }
//        func neitherDisagreeAgree() { }
//        func agreeLittle() { }
//        func agreeStrongly() { }
//    }

/*
        struct ContentView: View {
            var body: some View {
                Menu("Options") {
                    Button("Disagree Strongly", action: disagreeStrongly)
                    Button("Disagree a Little", action: disagreeLittle)
                    Button("Neither Agree or Disagree", action: neitherDisagreeAgree)
                    Button("Agree a Little", action: agreeLittle)
                    Button("Disagree Strongly", action: agreeStrongly)
                } primaryAction: {
                      justDoIt()
                }
            }

            func disagreeStrongly() { }
            func disagreeLittle() { }
            func neitherDisagreeAgree() { }
            func agreeLittle() { }
            func agreeStrongly() { }
        }
     
     
     // second view controller
     questionDisplayLabel.text = "\(userId) updateQ"
     questionDisplayLabel.lineBreakMode = .byWordWrapping
     questionDisplayLabel.numberOfLines = 0
     
     answerLabel.text = "updateA"
     // end
    */
