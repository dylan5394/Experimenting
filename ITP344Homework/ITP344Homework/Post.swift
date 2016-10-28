//
//  Post.swift
//  ITP344Homework
//
//  Created by Dylan Kyle Davis on 2/2/16.
//  Copyright © 2016 Dylan Davis. All rights reserved.
//

class Post : ModelBase, ModelProtocol {
    var cName : String?
    var cMessage : String?
    var cMessageDate : String?
    var cID : AnyObject?
    
    
    override func objectMapping() -> Dictionary<String, String>{
        
        let objecMapping = [
            "cName":"name",
            "cMessage":"message",
            "cMessageDate":"message_date",
            "cID":"id"
            
        ]
        
        return objecMapping
        
    }
    
}