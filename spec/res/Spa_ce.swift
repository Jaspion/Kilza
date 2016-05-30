//
//  Spa_ce.m
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

import Foundation

public class Spa_ce: NSObject, NSCoding {
    // Original names
    internal let kSpa_ce_1one: String = "1one"

    public var _1one: String?

    public class func model(obj: AnyObject) -> Spa_ce {
        var instance: Spa_ce?
        if (obj is String) {
            instance = Spa_ce.init(str: obj as! String)
        } else if (obj is Dictionary<String, AnyObject>) {
            instance = Spa_ce.init(dict: obj as! Dictionary)
        }
        return instance!
    }

    public convenience init(str: String) {
        var nStr: String = str
        if let trimmed: String = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) {
          if trimmed.hasPrefix("{") {
            nStr = "{ \"\\(kSpa_ce_1one)\" : \(str) }"
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
        self._1one = objectOrNil(forKey: kSpa_ce_1one, fromDictionary:dict) as? String
    }

    public func dictionaryRepresentation() -> Dictionary<String, AnyObject> {
        var mutableDict: Dictionary = [String: AnyObject]()
        mutableDict[kSpa_ce_1one] = self._1one
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
        self._1one = aDecoder.decodeObjectForKey(kSpa_ce_1one)! as? String
    }

    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(_1one, forKey:kSpa_ce_1one)
    }

    override public var description: String {
        get {
            return "\(dictionaryRepresentation())"
        }
    }
}