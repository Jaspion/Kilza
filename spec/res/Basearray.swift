//
//  Basearray.m
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

import Foundation

public class Basearray: NSObject, NSCoding {
    // Original names
    internal let kBasearrayBasearrayobject: String = "BaseArrayObject"

    public var basearrayobject: [String]?

    public class func model(obj: AnyObject) -> Basearray {
        var instance: Basearray?
        if (obj is String) {
            instance = Basearray.init(str: obj as! String)
        } else if (obj is Dictionary<String, AnyObject>) {
            instance = Basearray.init(dict: obj as! Dictionary)
        }
        return instance!
    }

    public convenience init(str: String) {
        var nStr: String = str
        if let trimmed: String = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) {
          if trimmed.hasPrefix("{") {
            nStr = "{ \"\\(kBasearrayBasearrayobject)\" : \(str) }"
          }
        }

        if let data = nStr.dataUsingEncoding(NSUTF8StringEncoding) {
          do {
              let object: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
              self.init(dict: object as! Dictionary)
          } catch _ as NSError {
              self.init(dict: Dictionary())
          }
        } else {
          self.init(dict: Dictionary())
        }
    }

    public init(dict: Dictionary<String, AnyObject>) {
      super.init()
        self.basearrayobject = objectOrNil(forKey: kBasearrayBasearrayobject, fromDictionary:dict) as? [String]
    }

    public func dictionaryRepresentation() -> Dictionary<String, AnyObject> {
        var mutableDict: Dictionary = [String: AnyObject]()
        mutableDict[kBasearrayBasearrayobject] = self.basearrayobject
        return NSDictionary.init(dictionary: mutableDict) as! Dictionary<String, AnyObject>
    }

    public func objectOrNil(forKey key: String, fromDictionary dict: Dictionary<String, AnyObject>) -> AnyObject?
    {
      if let object: AnyObject = dict[key] {
        if !(object is NSNull) {
          return object
        }
      }
      return nil
    }

    required public init(coder aDecoder: NSCoder) {
        self.basearrayobject = aDecoder.decodeObjectForKey(kBasearrayBasearrayobject)! as? [String]
    }

    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(basearrayobject, forKey:kBasearrayBasearrayobject)
    }

    override public var description: String {
        get {
            return "\(dictionaryRepresentation())"
        }
    }
}