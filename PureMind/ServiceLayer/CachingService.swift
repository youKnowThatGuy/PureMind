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
    
    func checkUserInfo()->Bool{
        let url = getServicesDirectory().appendingPathComponent("userInfo.json")
        
        if !fileManager.fileExists(atPath: url.path) || !fileManager.fileExists(atPath: fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("PersonalData").path){
            return false
        }
        else {
            return true
        }
    }
    
    private func getServicesDirectory()-> URL{
        let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("PersonalData")
        
        if !fileManager.fileExists(atPath: url.path){
            try! fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return url
    }
}
