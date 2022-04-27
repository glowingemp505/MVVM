//
//	Statu.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Statu : NSObject, NSCoding{

	var sentCount : Int!
	var verified : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		sentCount = dictionary["sentCount"] as? Int
		verified = dictionary["verified"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if sentCount != nil{
			dictionary["sentCount"] = sentCount
		}
		if verified != nil{
			dictionary["verified"] = verified
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         sentCount = aDecoder.decodeObject(forKey: "sentCount") as? Int
         verified = aDecoder.decodeObject(forKey: "verified") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if sentCount != nil{
			aCoder.encode(sentCount, forKey: "sentCount")
		}
		if verified != nil{
			aCoder.encode(verified, forKey: "verified")
		}

	}

}