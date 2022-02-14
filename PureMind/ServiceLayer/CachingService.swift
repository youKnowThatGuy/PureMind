//
//  CachingService.swift
//  PureMind
//
//  Created by Клим on 09.07.2021.
//

import Foundation

class CachingService{
    private init() {}
    static let shared = CachingService()
    private let fileManager = FileManager.default
    private let dateFormatter = DateFormatter()
    
    func cacheInfo(_ dataForjson: UserInfo?, completion: ((Bool)-> Void)? = nil){
        DispatchQueue.global(qos: .utility).async { [self] in
            
            guard let data = dataForjson else{
                completion?(false)
                return
            }
          let jsonUrl = getServicesDirectory().appendingPathComponent("userInfo.json")
            do{
                let codedData = try JSONEncoder().encode(data.self)
                try codedData.write(to: jsonUrl)
                completion?(true)
            }
            catch {
                print(error)
                completion?(false)
            }
        }
    }
    
    func getInfo(completion: @escaping (UserInfo?) -> Void){
        let jsonUrl = getServicesDirectory().appendingPathComponent("userInfo.json")
        DispatchQueue.global(qos: .userInteractive).async {
            
            if let data = self.fileManager.contents(atPath: jsonUrl.path){
                do{
                     let settings = try JSONDecoder().decode(UserInfo.self, from: data)
                        DispatchQueue.main.async {
                           completion(settings)
                         }
                   }
                
                catch{
                      print(error)
                       completion(nil)
                     }
            }
        }
    }
    
    func checkUserInfo()-> Bool{
        let url = getServicesDirectory().appendingPathComponent("userInfo.json")
        
        if !fileManager.fileExists(atPath: url.path) || !fileManager.fileExists(atPath: fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("PersonalData").path){
            return false
        }
        else {
            return true
        }
    }
    
    func deleteUserInfo(){
        let url = getServicesDirectory()
        do {
            try fileManager.removeItem(at: url)
        }
        catch{
            fatalError("Could not delete userInfo")
        }
    }
    
    func cacheMoodData(_ dataForjson: MoodInfo?, currDate: Date, completion: ((Bool)-> Void)? = nil){
        dateFormatter.dateFormat = "dd-MMMM-YYYY"
        let stringDate = dateFormatter.string(from: currDate)
        DispatchQueue.global(qos: .utility).async { [self] in
            guard let data = dataForjson else{
                completion?(false)
                return
            }
          let jsonUrl = getMoodDataDirectory().appendingPathComponent("\(stringDate)Info.json")
            do{
                let codedData = try JSONEncoder().encode(data.self)
                try codedData.write(to: jsonUrl)
                completion?(true)
            }
            catch {
                print(error)
                completion?(false)
            }
        }
    }
    
    func getMoodData(from path: String)-> MoodInfo?{
        if let data = fileManager.contents(atPath: path){
            do {
                let mood = try JSONDecoder().decode(MoodInfo.self, from: data)
                return mood
            }
            catch{
                return nil
            }
        }
        return nil
    }
    
    func getAllMoodData(completion: @escaping ([MoodInfo])-> Void){
        DispatchQueue.global().async { [self] in
            
        var moods = [MoodInfo]()
        let moodPaths = getCachedMoodPaths()
        for path in moodPaths{
            if let data = getMoodData(from: path){
                moods.append(data)
            }
        }
            moods.sort(by: {$1.date > $0.date})
            DispatchQueue.main.async {
            completion(moods)
            }
        }
    }
    
    func checkMoodInfo(currDate: Date)-> Bool{
        dateFormatter.dateFormat = "dd-MMMM-YYYY"
        let stringDate = dateFormatter.string(from: currDate)
        let url = getMoodDataDirectory().appendingPathComponent("\(stringDate)Info.json")
        
        if !fileManager.fileExists(atPath: url.path) || !fileManager.fileExists(atPath: fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("PersonalData").path){
            return false
        }
        else {
            return true
        }
    }
    
    private func getCachedMoodPaths()-> [String]{
        do{
            let paths = try fileManager.contentsOfDirectory(atPath: getMoodDataDirectory().path)
            return paths.map{getMoodDataDirectory().appendingPathComponent($0).path}
        }
        catch{
            return []
        }
    }

    
    private func getServicesDirectory()-> URL{
        let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("PersonalData")
        
        if !fileManager.fileExists(atPath: url.path){
            try! fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return url
    }
    
    private func getMoodDataDirectory()-> URL{
        let url = getServicesDirectory().appendingPathComponent("MoodData")
        
        if !fileManager.fileExists(atPath: url.path){
            try! fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return url
    }

}
