//
//  Special.m
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

import Foundation

public class Special: NSObject, NSCoding {
    // Original names
    internal let kSpecialA: String = "A"
    internal let kSpecial_b______: String = "[B]\"\"&^ "
    internal let kSpecialWith_some_spaces: String = "with some spaces"
    internal let kSpecialNew: String = "new"

    public var a: AnyObject?
    public var _b______: String?
    public var with_some_spaces: String?
    public var new: Int?

    public class func model(obj: AnyObject) -> Special {
        var instance: Special?
        if (obj is String) {
            instance = Special.init(str: obj as! String)
        } else if (obj is Dictionary<String, AnyObject>) {
            instance = Special.init(dict: obj as! Dictionary)
        }
        return instance!
    }

    public convenience init(str: String) {
        if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
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
        self.a = A.model(dict[kSpecialA]!)
        self._b______ = objectOrNil(forKey: kSpecial_b______, fromDictionary:dict) as? String
        self.with_some_spaces = objectOrNil(forKey: kSpecialWith_some_spaces, fromDictionary:dict) as? String
        self.new = objectOrNil(forKey: kSpecialNew, fromDictionary:dict) as? Int
    }

    public func dictionaryRepresentation() -> Dictionary<String, AnyObject> {
        var mutableDict: Dictionary = [String: AnyObject]()
        mutableDict[kSpecialA] = self.a
        mutableDict[kSpecial_b______] = self._b______
        mutableDict[kSpecialWith_some_spaces] = self.with_some_spaces
        mutableDict[kSpecialNew] = self.new
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
        self.a = aDecoder.decodeObjectForKey(kSpecialA)!
        self._b______ = aDecoder.decodeObjectForKey(kSpecial_b______)! as? String
        self.with_some_spaces = aDecoder.decodeObjectForKey(kSpecialWith_some_spaces)! as? String
        self.new = aDecoder.decodeObjectForKey(kSpecialNew)! as? Int
    }

    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(a, forKey:kSpecialA)
        aCoder.encodeObject(_b______, forKey:kSpecial_b______)
        aCoder.encodeObject(with_some_spaces, forKey:kSpecialWith_some_spaces)
        aCoder.encodeObject(new, forKey:kSpecialNew)
    }

    override public var description: String {
        get {
            return "\(dictionaryRepresentation())"
        }
    }
}
