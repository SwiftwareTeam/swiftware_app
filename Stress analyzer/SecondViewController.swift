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

    
    var studentNum: String?
    var surveyQuestion: String?
    var surveyResponse: String?
    
    
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var questionDisplayLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    
    @IBAction func prevQButton(_ sender: Any) {
    }
    @IBAction func nextQButton(_ sender: Any) {
    }
    @IBAction func insertButton(_ sender: Any) {
    }
    @IBAction func deleteButton(_ sender: Any) {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        view.backgroundColor = .systemBackground
        studentLabel.text = studentNum
        questionDisplayLabel.text = surveyQuestion
        responseLabel.text = surveyResponse
        */
        if studentNum != nil {
            studentLabel.text = studentNum
        }
        if surveyQuestion != nil {
            questionDisplayLabel.text = surveyQuestion
        }
        if surveyResponse != nil {
            responseLabel.text = surveyResponse
        }
        // Do any additional setup after loading the view.
    }
}
