//
//  ServerAPIManager.swift
//  ITPRestApplication
//
//  Created by Demo on 1/28/16.
//

import Foundation

class ServerAPIManager : ManagerBase{
    
    let baseUrl = "https://freezing-cloud-6077.herokuapp.com"
    
    enum Resources : String {
        case Posts = "messages.json", Resource2 = "resource2", Resource3 = "resource3"
        
    }
    
    
    // check out differnt options for singleton patterns, http://krakendev.io/blog/the-right-way-to-write-a-singleton
    class var sharedInstance: ServerAPIManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ServerAPIManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = ServerAPIManager()
        }
        return Static.instance!
    }
    
    
    func readResource(resource : Resources, callback:(data : AnyObject?, error: AnyObject?)->()) -> Void{
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)/\(resource.rawValue)")!)
        print("\(resource.rawValue)")

        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback(data: nil, error: error)
            } else {
                
                if let data = data{
                    

                    let dict = self.convertJsonDataToDictionary(data)
                    
                    callback(data: dict, error: nil)
                    
                }else{
                    
                    callback(data: nil, error: nil)
                    
                }
                
            }
            
        }
        task.resume()
        
        
        
    }
    
    func createResource(resource : Resources, data : Dictionary<String, AnyObject>, callback:(data : AnyObject?, error: AnyObject?)->()) -> Void{
        
        let postData = convertDictionaryToJsonData(data)
        
        print("\(resource.rawValue)")
        //print(convertDataToString(postData!))
        
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)/\(resource.rawValue)")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: 30.0)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
  
        let session = NSURLSession.sharedSession()
        
        let task = session.uploadTaskWithRequest(request,
            fromData: postData) {
                (data, response, error) -> Void in
                
                if let data = data{
                    
                    let dict =  self.convertJsonDataToDictionary(data)
                    callback(data: dict, error: nil)
                    
                    
                }else{
                    
                    callback(data: nil, error: nil)
                    
                }
                
        }
        task.resume()
        
    }
    
    func delete(resource : Resources, callback:(data : AnyObject?, error: AnyObject?)->()) -> Void{
        
        
        
    }
    
    
    func convertDataToString(inputData : NSData) -> NSString?{
        
        let returnString = String(data: inputData, encoding: NSUTF8StringEncoding)
        //print(returnString)
        return returnString
        
    }
    
    
    func convertDictionaryToJsonData(inputDict : Dictionary<String, AnyObject>) -> NSData?{
        
        do{
            return try NSJSONSerialization.dataWithJSONObject(inputDict, options:NSJSONWritingOptions.PrettyPrinted)
            
        }catch let error as NSError{
            print(error)
            
        }
        
        return nil
    }
    
    
    func convertJsonDataToDictionary(inputData : NSData) -> Array<[String:AnyObject]>? {
        guard inputData.length > 1 else{ return nil }  // avoid processing empty responses
        
        do {
            return try NSJSONSerialization.JSONObjectWithData(inputData, options: []) as? Array<Dictionary<String, AnyObject>>
        }catch let error as NSError{
            print(error)
            
        }
        return nil
    }
    
    func convertJsonStringToDictionary(text: String) -> Array<Dictionary<String, AnyObject>>? {
        
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? Array<Dictionary<String, AnyObject>>
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    
    
    
    
}
