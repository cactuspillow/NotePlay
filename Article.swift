//
//  Article.swift
//  
//
//  Created by shikaiwen on 5/9/2015.
//
//

import Foundation
import CoreData

@objc(Article)

class Article: NSManagedObject {
  
    @NSManaged var articleID: Int32
    @NSManaged var id: NSNumber
    @NSManaged var content: String

}
