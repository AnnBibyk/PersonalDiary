//
//  Article+CoreDataClass.swift
//  
//
//  Created by Anna BIBYK on 1/25/19.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject {
    
    override public var description: String {
        return "\(title!)\n\(content!)\n\(language!)\n\(creation_date!)\n\(modification_date!)\n\n"
    }
}
