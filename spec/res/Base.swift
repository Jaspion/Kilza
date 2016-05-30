//
//  Base.m
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

import Foundation

public class Base: NSObject, NSCoding {
    // Original names
    internal let kBase_myid: String = "id"
    internal let kBaseStr: String = "str"
    internal let kBaseNum: String = "num"
    internal let kBaseFlo: String = "flo"
    internal let kBaseBoo: String = "boo"
    internal let kBaseSpa_ce: String = "spa ce"
    internal let kBaseSpecial: String = "special"
    internal let kBaseArrdouble: String = "arrdouble"
    internal let kBaseArrnum: String = "arrnum"
    internal let kBaseArrstr: String = "arrstr"
    internal let kBaseArrboo: String = "arrboo"
    internal let kBaseArrnull: String = "arrnull"
    internal let kBaseObj: String = "obj"
    internal let kBaseArrobj: String = "arrobj"

    public var _myid: String?
    public var str: String?
    public var num: Int?
    public var flo: Double?
    public var boo: Bool?
    public var spa_ce: Spa_ce?
    public var special: Special?
    public var arrdouble: [Double]?
    public var arrnum: [Int]?
    public var arrstr: [String]?
    public var arrboo: [Bool]?
    public var arrnull: [Arrnull]?
    public var obj: Obj?
    public var arrobj: [Arrobj]?

    public class func model(obj: AnyObject) -> Base {
        var instance: Base?
        if (obj is String) {
            instance = Base.init(str: obj as! String)
        } else if (obj is Dictionary<String, AnyObject>) {
            instance = Base.init(dict: obj as! Dictionary)
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
        self._myid = objectOrNil(forKey: kBase_myid, fromDictionary:dict) as? String
        self.str = objectOrNil(forKey: kBaseStr, fromDictionary:dict) as? String
        self.num = objectOrNil(forKey: kBaseNum, fromDictionary:dict) as? Int
        self.flo = objectOrNil(forKey: kBaseFlo, fromDictionary:dict) as? Double
        self.boo = objectOrNil(forKey: kBaseBoo, fromDictionary:dict) as? Bool
        self.spa_ce = Spa_ce.model(dict[kBaseSpa_ce]!)
        self.special = Special.model(dict[kBaseSpecial]!)
        self.arrdouble = objectOrNil(forKey: kBaseArrdouble, fromDictionary:dict) as? [Double]
        self.arrnum = objectOrNil(forKey: kBaseArrnum, fromDictionary:dict) as? [Int]
        self.arrstr = objectOrNil(forKey: kBaseArrstr, fromDictionary:dict) as? [String]
        self.arrboo = objectOrNil(forKey: kBaseArrboo, fromDictionary:dict) as? [Bool]
        let objArrnull: [AnyObject] = dict[kBaseArrnull]! as! [AnyObject]
        var listArrnull = [Arrnull]()
        for item in objArrnull {
            if item is Dictionary<String, AnyObject> {
                listArrnull.append(Arrnull.model(item))
            }
        }
        self.arrnull = listArrnull
        self.obj = Obj.model(dict[kBaseObj]!)
        let objArrobj: [AnyObject] = dict[kBaseArrobj]! as! [AnyObject]
        var listArrobj = [Arrobj]()
        for item in objArrobj {
            if item is Dictionary<String, AnyObject> {
                listArrobj.append(Arrobj.model(item))
            }
        }
        self.arrobj = listArrobj
    }

    public func dictionaryRepresentation() -> Dictionary<String, AnyObject> {
        var mutableDict: Dictionary = [String: AnyObject]()
        mutableDict[kBase_myid] = self._myid
        mutableDict[kBaseStr] = self.str
        mutableDict[kBaseNum] = self.num
        mutableDict[kBaseFlo] = self.flo
        mutableDict[kBaseBoo] = self.boo
        if let dic = spa_ce?.dictionaryRepresentation() {
            mutableDict[kBaseSpa_ce] = dic
        } else {
            mutableDict[kBaseSpa_ce] = self.spa_ce
        }
        if let dic = special?.dictionaryRepresentation() {
            mutableDict[kBaseSpecial] = dic
        } else {
            mutableDict[kBaseSpecial] = self.special
        }
        mutableDict[kBaseArrdouble] = self.arrdouble
        mutableDict[kBaseArrnum] = self.arrnum
        mutableDict[kBaseArrstr] = self.arrstr
        mutableDict[kBaseArrboo] = self.arrboo
        var tempArrayArrnull = [Dictionary<String, AnyObject>]()
        for subArray in self.arrnull! {
            if let dicRepresentation: Dictionary<String, AnyObject> = subArray.dictionaryRepresentation() {
                 tempArrayArrnull.append(dicRepresentation)
            }
        }
        mutableDict[kBaseArrnull] = Array.init(tempArrayArrnull)
        if let dic = obj?.dictionaryRepresentation() {
            mutableDict[kBaseObj] = dic
        } else {
            mutableDict[kBaseObj] = self.obj
        }
        var tempArrayArrobj = [Dictionary<String, AnyObject>]()
        for subArray in self.arrobj! {
            if let dicRepresentation: Dictionary<String, AnyObject> = subArray.dictionaryRepresentation() {
                 tempArrayArrobj.append(dicRepresentation)
            }
        }
        mutableDict[kBaseArrobj] = Array.init(tempArrayArrobj)
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
        self._myid = aDecoder.decodeObjectForKey(kBase_myid)! as? String
        self.str = aDecoder.decodeObjectForKey(kBaseStr)! as? String
        self.num = aDecoder.decodeObjectForKey(kBaseNum)! as? Int
        self.flo = aDecoder.decodeObjectForKey(kBaseFlo)! as? Double
        self.boo = aDecoder.decodeObjectForKey(kBaseBoo)! as? Bool
        self.spa_ce = aDecoder.decodeObjectForKey(kBaseSpa_ce)! as? Spa_ce
        self.special = aDecoder.decodeObjectForKey(kBaseSpecial)! as? Special
        self.arrdouble = aDecoder.decodeObjectForKey(kBaseArrdouble)! as? [Double]
        self.arrnum = aDecoder.decodeObjectForKey(kBaseArrnum)! as? [Int]
        self.arrstr = aDecoder.decodeObjectForKey(kBaseArrstr)! as? [String]
        self.arrboo = aDecoder.decodeObjectForKey(kBaseArrboo)! as? [Bool]
        self.arrnull = aDecoder.decodeObjectForKey(kBaseArrnull)! as? [Arrnull]
        self.obj = aDecoder.decodeObjectForKey(kBaseObj)! as? Obj
        self.arrobj = aDecoder.decodeObjectForKey(kBaseArrobj)! as? [Arrobj]
    }

    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(_myid, forKey:kBase_myid)
        aCoder.encodeObject(str, forKey:kBaseStr)
        aCoder.encodeObject(num, forKey:kBaseNum)
        aCoder.encodeObject(flo, forKey:kBaseFlo)
        aCoder.encodeObject(boo, forKey:kBaseBoo)
        aCoder.encodeObject(spa_ce, forKey:kBaseSpa_ce)
        aCoder.encodeObject(special, forKey:kBaseSpecial)
        aCoder.encodeObject(arrdouble, forKey:kBaseArrdouble)
        aCoder.encodeObject(arrnum, forKey:kBaseArrnum)
        aCoder.encodeObject(arrstr, forKey:kBaseArrstr)
        aCoder.encodeObject(arrboo, forKey:kBaseArrboo)
        aCoder.encodeObject(arrnull, forKey:kBaseArrnull)
        aCoder.encodeObject(obj, forKey:kBaseObj)
        aCoder.encodeObject(arrobj, forKey:kBaseArrobj)
    }

    override public var description: String {
        get {
            return "\(dictionaryRepresentation())"
        }
    }
}
