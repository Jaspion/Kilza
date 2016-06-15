//
//  BaseArray.swift
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//  Generated by Kilza https://github.com/Jaspion/Kilza
//

import Foundation

public class BaseArray: NSObject, NSCoding {
    // Original names
    static let kBaseArrayBasearrayobject: String = "BaseArrayObject"

    public var basearrayobject: [String]?

    public class func model(obj: AnyObject) -> BaseArray? {
        var instance: BaseArray?
        if (obj is String) {
            instance = BaseArray.init(str: obj as! String)
        } else if (obj is Dictionary<String, AnyObject>) {
            instance = BaseArray.init(dict: obj as! Dictionary)
        }
        return instance
    }

    public convenience init?(str: String) {
        var nStr: String = str
        if let trimmed: String = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) {
            if !trimmed.hasPrefix("{") {
                nStr = "{ \"\(BaseArray.kBaseArrayBasearrayobject)\" : \(str) }"
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
        self.basearrayobject = objectOrNil(forKey: BaseArray.kBaseArrayBasearrayobject, fromDictionary:dict) as? [String]
    }

    public func dictionaryRepresentation() -> Dictionary<String, AnyObject> {
        var mutableDict: Dictionary = [String: AnyObject]()
        mutableDict[BaseArray.kBaseArrayBasearrayobject] = self.basearrayobject
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
        self.basearrayobject = aDecoder.decodeObjectForKey(BaseArray.kBaseArrayBasearrayobject)! as? [String]
    }

    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(basearrayobject, forKey:BaseArray.kBaseArrayBasearrayobject)
    }

    override public var description: String {
        get {
            return "\(dictionaryRepresentation())"
        }
    }
}
