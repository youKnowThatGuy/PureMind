//
//  NetworkService.swift
//  PureMind
//
//  Created by Клим on 09.07.2021.
//

import UIKit

class NetworkService{
    private init(){}
                        
    static let shared = NetworkService()
    
    var apiKey = ""
    
    private var baseUrlComponent: URLComponents {
        var _urlComps = URLComponents(string: "http://188.120.236.134:3080")!
        _urlComps.queryItems = []
        return _urlComps
    }
    
     func logIN(login: String, password: String, completion: @escaping (Result<String, SessionError>) -> Void){
        var urlComps = baseUrlComponent
        urlComps.path = "/api/auth/login"
        //urlComps.queryItems? += [
        //URLQueryItem(name: "login", value: "\(login)"),
        //URLQueryItem(name: "password", value: "\(password)")
        //]
        
        guard let url = urlComps.url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidUrl))
            }
            return
        }
        
        let parameters: [String: String] = ["login": login, "password": password]
        var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("'\(apiKey)'", forHTTPHeaderField: "Token")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.other(error)))
                }
                return
            }
            let response = response as! HTTPURLResponse
            
            guard let data = data, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(.serverError(response.statusCode)))
                }
                return
            }
            do {
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]
                let serverResponse = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
                DispatchQueue.main.async {
                    completion(.success(serverResponse!.string))
                }
            }
            /*
            catch let decodingError{
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(decodingError)))
                }
                
            }
 */
        }.resume()
    }
    
    func getPractices(completion: @escaping (Result<[PracticesInfo], SessionError>) -> Void){
        var urlComps = baseUrlComponent
        urlComps.path = "/api/practices"
        
        guard let url = urlComps.url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidUrl))
            }
            return
        }
        
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
        let text = apiKey.replacingOccurrences(of: "\"", with: "")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(text, forHTTPHeaderField: "Token")
       
       URLSession.shared.dataTask(with: request) { (data, response, error) in
           if let error = error {
               DispatchQueue.main.async {
                   completion(.failure(.other(error)))
               }
               return
           }
           let response = response as! HTTPURLResponse
           
           guard let data = data, response.statusCode == 200 else {
               DispatchQueue.main.async {
                   completion(.failure(.serverError(response.statusCode)))
               }
               return
           }
        do {
            let serverResponse = try JSONDecoder().decode([PracticesInfo].self, from: data)
            DispatchQueue.main.async {
                completion(.success(serverResponse))
            }
        }
        catch let decodingError{
            DispatchQueue.main.async {
                completion(.failure(.decodingError(decodingError)))
            }
            
        }
       }.resume()
   }
    
    func getCourses(completion: @escaping (Result<[CoursesInfo], SessionError>) -> Void){
        var urlComps = baseUrlComponent
        urlComps.path = "/api/courses"
        
        guard let url = urlComps.url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidUrl))
            }
            return
        }
        
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
        let text = apiKey.replacingOccurrences(of: "\"", with: "")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(text, forHTTPHeaderField: "Token")
       
       URLSession.shared.dataTask(with: request) { (data, response, error) in
           if let error = error {
               DispatchQueue.main.async {
                   completion(.failure(.other(error)))
               }
               return
           }
           let response = response as! HTTPURLResponse
           
           guard let data = data, response.statusCode == 200 else {
               DispatchQueue.main.async {
                   completion(.failure(.serverError(response.statusCode)))
               }
               return
           }
        do {
            let serverResponse = try JSONDecoder().decode([CoursesInfo].self, from: data)
            DispatchQueue.main.async {
                completion(.success(serverResponse))
            }
        }
        catch let decodingError{
            DispatchQueue.main.async {
                completion(.failure(.decodingError(decodingError)))
            }
            
        }
       }.resume()
   }
    
    func getAllExcerciseData(practicId: String, completion: @escaping (Result<[ExcerciseInfo], SessionError>) -> Void){
        var results = [ExcerciseInfo]()
        getExcercises(practicId: practicId) {[weak self] (result) in
            switch result{
            case let .failure(error):
                completion(.failure(error))
            
            case let .success(shortInfo):
                let d = DispatchGroup()
                for info in shortInfo{
                    d.enter()
                    DispatchQueue.global().sync{
                        self?.getExcercise(excerciseId: info.id) {(fullInfo) in
                            switch fullInfo{
                            case let .failure(error):
                                completion(.failure(error))
                            case let .success(exc):
                                results.append(exc)
                            }
                            d.leave()
                        }
                    }
                }
                d.notify(queue: .main){
                    DispatchQueue.main.async {
                        completion(.success(results))
                    }
                }
            }
        }
    }
    
    
   private func getExcercises(practicId: String, completion: @escaping (Result<[ShortExcerciseInfo], SessionError>) -> Void){
        var urlComps = baseUrlComponent
        urlComps.path = "/api/practices/\(practicId)/exercises"
        
        guard let url = urlComps.url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidUrl))
            }
            return
        }
        
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
        let text = apiKey.replacingOccurrences(of: "\"", with: "")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(text, forHTTPHeaderField: "Token")
       
       URLSession.shared.dataTask(with: request) { (data, response, error) in
           if let error = error {
               DispatchQueue.main.async {
                   completion(.failure(.other(error)))
               }
               return
           }
           let response = response as! HTTPURLResponse
           
           guard let data = data, response.statusCode == 200 else {
               DispatchQueue.main.async {
                   completion(.failure(.serverError(response.statusCode)))
               }
               return
           }
        do {
            let serverResponse = try JSONDecoder().decode([ShortExcerciseInfo].self, from: data)
            DispatchQueue.main.async {
                completion(.success(serverResponse))
            }
        }
        catch let decodingError{
            DispatchQueue.main.async {
                completion(.failure(.decodingError(decodingError)))
            }
            
        }
       }.resume()
   }
    
    func getAudio(audioId: String, completion: @escaping (Result<Data, SessionError>) -> Void){
         var urlComps = baseUrlComponent
         urlComps.path = "/api/audios/\(audioId)"
         
         guard let url = urlComps.url else {
             DispatchQueue.main.async {
                 completion(.failure(.invalidUrl))
             }
             return
         }
         
         var request = URLRequest(url: url)
             request.httpMethod = "GET"
         
         let text = apiKey.replacingOccurrences(of: "\"", with: "")
         
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.addValue("application/json", forHTTPHeaderField: "Accept")
         request.addValue(text, forHTTPHeaderField: "Token")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.other(error)))
                }
                return
            }
            let response = response as! HTTPURLResponse
            
            guard let data = data, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(.serverError(response.statusCode)))
                }
                return
            }
             DispatchQueue.main.async {
                 completion(.success(data))
             }
         
        }.resume()
    }
    
    private func getExcercise(excerciseId: String, completion: @escaping (Result<ExcerciseInfo, SessionError>) -> Void){
        var urlComps = baseUrlComponent
        urlComps.path = "/api/exercises/\(excerciseId)"
        
        guard let url = urlComps.url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidUrl))
            }
            return
        }
        
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
        let text = apiKey.replacingOccurrences(of: "\"", with: "")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(text, forHTTPHeaderField: "Token")
       
       URLSession.shared.dataTask(with: request) { (data, response, error) in
           if let error = error {
               DispatchQueue.main.async {
                   completion(.failure(.other(error)))
               }
               return
           }
           let response = response as! HTTPURLResponse
           
           guard let data = data, response.statusCode == 200 else {
               DispatchQueue.main.async {
                   completion(.failure(.serverError(response.statusCode)))
               }
               return
           }
        do {
            let serverResponse = try JSONDecoder().decode(ExcerciseInfo.self, from: data)
            DispatchQueue.main.async {
                completion(.success(serverResponse))
            }
        }
        catch let decodingError{
            DispatchQueue.main.async {
                completion(.failure(.decodingError(decodingError)))
            }
            
        }
       }.resume()
   }
    
    func registerUser(nickname: String, email: String, password: String, completion: @escaping (Result<String, SessionError>) -> Void){
       var urlComps = baseUrlComponent
       urlComps.path = "/api/auth/registration"
       
       guard let url = urlComps.url else {
           DispatchQueue.main.async {
               completion(.failure(.invalidUrl))
           }
           return
       }
        
       let parameters: [String: String] = ["nickname": nickname, "email": email, "password": password]
       var request = URLRequest(url: url)
           request.httpMethod = "PUT"
           do {
               request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
           } catch let error {
            DispatchQueue.main.async {
                completion(.failure(.decodingError(error)))
            }
           }
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       request.addValue("application/json", forHTTPHeaderField: "Accept")
       
       URLSession.shared.dataTask(with: request) { (data, response, error) in
           if let error = error {
               DispatchQueue.main.async {
                   completion(.failure(.other(error)))
               }
               return
           }
           let response = response as! HTTPURLResponse
           
           guard let data = data, response.statusCode == 200 else {
               DispatchQueue.main.async {
                   completion(.failure(.serverError(response.statusCode)))
               }
               return
           }
           do {
               let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                   .documentType: NSAttributedString.DocumentType.html,
                   .characterEncoding: String.Encoding.utf8.rawValue
               ]
               let serverResponse = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
               DispatchQueue.main.async {
                   completion(.success(serverResponse!.string))
               }
           }
       }.resume()
   }
   
    func sendExcerciseAnswer(excerciseId: String, selectionAnswers: [String], customAnswer: String, completion: @escaping (Result<String, SessionError>) -> Void){
       var urlComps = baseUrlComponent
       urlComps.path = "/api/exercises/\(excerciseId)/answer"
       
       guard let url = urlComps.url else {
           DispatchQueue.main.async {
               completion(.failure(.invalidUrl))
           }
           return
       }
        
       let parameters: [String: [String]] = ["selectionAnswers": selectionAnswers, "customAnswers": [customAnswer]]
       var request = URLRequest(url: url)
           request.httpMethod = "POST"
           do {
               request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
           } catch let error {
            DispatchQueue.main.async {
                completion(.failure(.decodingError(error)))
            }
           }
        
        let text = apiKey.replacingOccurrences(of: "\"", with: "")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(text, forHTTPHeaderField: "Token")
       
       URLSession.shared.dataTask(with: request) { (data, response, error) in
           if let error = error {
               DispatchQueue.main.async {
                   completion(.failure(.other(error)))
               }
               return
           }
           let response = response as! HTTPURLResponse
           
           guard let data = data, response.statusCode == 200 else {
               DispatchQueue.main.async {
                print(response.statusCode)
                   completion(.failure(.serverError(response.statusCode)))
               }
               return
           }
           do {
               let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                   .documentType: NSAttributedString.DocumentType.html,
                   .characterEncoding: String.Encoding.utf8.rawValue
               ]
               let serverResponse = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
               DispatchQueue.main.async {
                   completion(.success(serverResponse!.string))
               }
           }
       }.resume()
   }
    
}

