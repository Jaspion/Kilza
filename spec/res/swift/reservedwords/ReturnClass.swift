//
//  ReturnClass.swift
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//  Generated by Kilza https://github.com/Jaspion/Kilza
//

import Foundation

public class ReturnClass: NSObject, NSCoding {
    // Original names
    static let kReturnClass_id: String = "id"

    public var _id: Int?

    public class func model(obj: AnyObject) -> ReturnClass? {
        var instance: ReturnClass?
        if (obj is String) {
            instance = ReturnClass.init(str: obj as! String)
        } else if (obj is Dictionary<String, AnyObject>) {
            instance = ReturnClass.init(dict: obj as! Dictionary)
        }
        return instance
    }

    public convenience init?(str: String) {
        var nStr: String = str
        if let trimmed: String = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) {
            if !trimmed.hasPrefix("{") {
                nStr = "{ \"\(ReturnClass.kReturnClass_id)\" : \(str) }"
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

    public init?(dict: Dictionary<String, AnyObject>) {
        super.init()
        self._id = objectOrNil(forKey: ReturnClass.kReturnClass_id, fromDictionary:dict) as? Int
    }

    public func dictionaryRepresentation() -> Dictionary<String, AnyObject> {
        var mutableDict: Dictionary = [String: AnyObject]()
        mutableDict[ReturnClass.kReturnClass_id] = self._id
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
        self._id = aDecoder.decodeObjectForKey(ReturnClass.kReturnClass_id)! as? Int
    }

    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(_id, forKey:ReturnClass.kReturnClass_id)
    }

    override public var description: String {
        get {
            return "\(dictionaryRepresentation())"
        }
    }
}
