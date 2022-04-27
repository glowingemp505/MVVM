
import Foundation


class Model: NSObject, NSCoding{

	var v : Int!
	var id : String!
	var createdAt : String!
	var deleted : Bool!
	var source : String!
	var status : Statu!
	var text : String!
	var type : String!
	var updatedAt : String!
	var used : Bool!
	var user : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		v = dictionary["__v"] as? Int
		id = dictionary["_id"] as? String
		createdAt = dictionary["createdAt"] as? String
		deleted = dictionary["deleted"] as? Bool
		source = dictionary["source"] as? String
		if let statusData = dictionary["status"] as? [String:Any]{
			status = Statu(fromDictionary: statusData)
		}
		text = dictionary["text"] as? String
		type = dictionary["type"] as? String
		updatedAt = dictionary["updatedAt"] as? String
		used = dictionary["used"] as? Bool
		user = dictionary["user"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if v != nil{
			dictionary["__v"] = v
		}
		if id != nil{
			dictionary["_id"] = id
		}
		if createdAt != nil{
			dictionary["createdAt"] = createdAt
		}
		if deleted != nil{
			dictionary["deleted"] = deleted
		}
		if source != nil{
			dictionary["source"] = source
		}
		if status != nil{
			dictionary["status"] = status.toDictionary()
		}
		if text != nil{
			dictionary["text"] = text
		}
		if type != nil{
			dictionary["type"] = type
		}
		if updatedAt != nil{
			dictionary["updatedAt"] = updatedAt
		}
		if used != nil{
			dictionary["used"] = used
		}
		if user != nil{
			dictionary["user"] = user
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         v = aDecoder.decodeObject(forKey: "__v") as? Int
         id = aDecoder.decodeObject(forKey: "_id") as? String
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         deleted = aDecoder.decodeObject(forKey: "deleted") as? Bool
         source = aDecoder.decodeObject(forKey: "source") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Statu
         text = aDecoder.decodeObject(forKey: "text") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
         used = aDecoder.decodeObject(forKey: "used") as? Bool
         user = aDecoder.decodeObject(forKey: "user") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if v != nil{
			aCoder.encode(v, forKey: "__v")
		}
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if deleted != nil{
			aCoder.encode(deleted, forKey: "deleted")
		}
		if source != nil{
			aCoder.encode(source, forKey: "source")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if text != nil{
			aCoder.encode(text, forKey: "text")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}
		if used != nil{
			aCoder.encode(used, forKey: "used")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}
