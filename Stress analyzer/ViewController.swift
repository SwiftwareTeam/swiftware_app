//
//  ViewController.swift
//  Stress analyzer
//
//  Created by Adrian on 4/12/22.
//
//import UIKit
import SwiftUI
import Foundation
import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var searched: String?
    let searchControl = UISearchController(searchResultsController: resultView())
    
    private var sN: String = "" //studnet number
    private var sQ: String = "" //student question
    private var sR: String = "" //student response
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchControl.searchBar.text else {
            return
        }
        searched = text;
        print(searched!)
    }
    


    
    
    //let student = studentStress()
    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    
    var Data = [String]()
    var Filtered = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...56 {
            if (i < 10) {
                Data.append("u0\(i)")
            } else {
                Data.append("u\(i)")
            }
        }
        
        // Do any additional setup after loading the view.
        //searchText.delegate = self
        
        title = "Search"
        //searchControl.searchResultsUpdater = self
        
        table.delegate = self
        table.dataSource = self
        table.isHidden = true
        field.delegate = self
        //navigationItem.searchController = searchControl
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let fieldtext = textField.text {
            let query = fieldtext + string
            Filtered.removeAll()
            for str in Data {
                if str.contains(query) {
                    Filtered.append(str)
                }
            }
            table.reloadData()
        }
        
        
        return true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Filtered.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        tableCell.textLabel?.text = Filtered[indexPath.row]
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("im there: " + Filtered[indexPath.row])
        do{
            try sendQueryToServer(Filtered[indexPath.row])
        }
        catch{
            print ("error has occurred while sending query to server in table view")
        }
        tableView.isHidden = true
        /* test case
        sN = "U00"
        sQ = "I see myself as a kind person"
        sR = "Agree a Little"
         */
        let vc = storyboard?.instantiateViewController(identifier: "secondVC") as! SecondViewController
        sN = Filtered[indexPath.row]
        vc.studentNum = sN
        vc.surveyQuestion = sQ
        vc.surveyResponse = sR
        present(vc, animated: true)
        //tableView.removeFromSuperview()
    }
    
    struct UserResponse: Codable {
        var post: Dictionary<String,String>
    }
    var baseEndpoint = "http://swiftware.tech/getResponses/"
    //added an exception domain to the link above, changed from https to http
    
    func sendQueryToServer(_ userId: String) throws    {
        // query contains u## selected from
        // after dictionary is returned
        questionLabel.text = "\(userId) updateQ"
        answerLabel.text = "updateA"
        
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 0
        
        enum APIError: Error {
            case invalidHTTPStatus
            case emptyUserID
        }
        
        if userId.isEmpty{
            throw (APIError.emptyUserID)
        }
        
        let myDict = [String: String]()
        var userResponse = UserResponse(post:myDict)

        //endpoint = endpoint + userId
        let localEndpoint = baseEndpoint + userId
        
        print("start execute URL: " + localEndpoint)
        
        let url = URL(string: localEndpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
    
        let task = URLSession.shared.dataTask(with: url) { [self](data, response, error) in
            guard let data = data else { return }
            _ = String(data: data, encoding: .utf8)!
             do{
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    print ("httpResponse.statusCode: \(httpResponse.statusCode)")
                    throw (APIError.invalidHTTPStatus)
                }
                
                userResponse = try JSONDecoder().decode(UserResponse.self,from:data)
                 self.sQ = userResponse.post.keys.first ?? ""
                 self.sR = userResponse.post.values.first ?? ""
                print("question label: " , userResponse.post.keys.first ?? "")
                print("answer label: " , userResponse.post.values.first ?? "")
                DispatchQueue.main.async {
                    for question in userResponse.post.keys{
                       "\(userId) Answer: " + (userResponse.post[question] ?? "")
                    }
                   
                }
                print("http response:  \(String(describing: response))" )
                print ("user response: " , userResponse)
            }
            catch {
                print("JSONSerialization error:", error)
            }
            
        }
    
        print ("end execute URL")

        task.resume()

    }
    
    
//KEYBOARD STUFF:
    
    lazy var touchView: UIView = {
        
        let _touchView = UIView()
        
        _touchView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0)
        
        let touchViewTapped = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        _touchView.addGestureRecognizer(touchViewTapped)
        
        _touchView.isUserInteractionEnabled = true
        
        _touchView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        return _touchView
        
        
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        deregisterFromKeyboardNotification()
        
    }
    
    func registerForKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIWindow.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    func deregisterFromKeyboardNotification() {
        
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    var activeTextField: UITextField?
    
    var activeTextView: UITextView?
    
    let toolBarDone = UIToolbar.init()
    
    @objc func keyboardWasShown(notification: NSNotification) {
        
        view.addSubview(touchView)
        
        table.isHidden = false;
        
        let info: NSDictionary = notification.userInfo! as NSDictionary
        
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        
       // let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: (keyboardSize!.height + toolBarDone.frame.size.height + 10.0), right: 0.0)
        
        var aRect: CGRect = UIScreen.main.bounds
        
        aRect.size.height -= keyboardSize!.height
        
        
    }
    
    
    @objc func keyboardWasHidden(notification: NSNotification) {
        
        touchView.removeFromSuperview()
        //table.isHidden = true
      //  let contentInsets: UIEdgeInsets = UIEdgeInsets.zero
        
        self.view.endEditing(true)
        
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
        
    }
    
    @IBAction func searchBar(_ sender: Any) {
        
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }
    
    @IBOutlet weak var searchText: UITextField!
    

}
extension ViewController  {
    private func textFieldShouldReturn(_ textField: UISearchController) -> Bool {
        textField.resignFirstResponder()
        searched = searchText.text!
        
        print(searched! + "final result\n")
        return true
    }
}
