//
//  Data.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 11.07.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import Foundation


protocol QuestionProtocol: class {
    func questionsDownloaded(items: NSArray)
}

class Question: NSObject, URLSessionDelegate {
    var q_id: String
    var q_question: String
    
    weak var delegate: QuestionProtocol!
    
    var data = Data()
    
    let urlPath = "https://12ceyrek.me/fiveSecondQuestions.php"
    
    func downloadQuestions() {
        let url:URL = URL(string: urlPath)!
        
        var array = NSMutableArray()
        
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("failed to download data")
            }else {
                guard let data = data else { return }
                
                array = self.parseJSON(data)
                print("Number of the downladed are \(array.count)")
            }
        }
        
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> NSMutableArray {
        do {
            guard let jsonResult = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else{
                print("Invalid JSON Structure")
                return []
            }
            
            let questions = NSMutableArray()
            
            for jsonElement in jsonResult {
                if
                    let question = jsonElement["q_question"] as? String,
                    let id = jsonElement["q_id"] as? String {
                    
                    let tempQuestion = Question()
                    
                    tempQuestion.q_id = id
                    tempQuestion.q_question = question
                    
                    questions.add(tempQuestion)
                }else {
                    print("There is an eerror while appending the array to json Elements")
                }
                
            }
            
            DispatchQueue.main.async {
                self.delegate.questionsDownloaded(items: questions)
            }
            
            return questions
            
        } catch let error {
            print(error)
            return []
        }
    }
    
    override init() {
        self.q_id = ""
        self.q_question = ""
    }
    
    init(q_id: String, q_question: String) {
        self.q_id = q_id
        self.q_question = q_question
    }
    
}
