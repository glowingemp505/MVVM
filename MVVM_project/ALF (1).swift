//
//  ALF.swift
//  Seleckt
//
//  Created by Tausif on 29/11/2021.
//


import Foundation
import UIKit
import Alamofire
import SwiftUI

typealias SuccessBlock = (_ response: AnyObject) -> Void
typealias FailureBlock = (_ response: AnyObject) -> Void

class ALF: NSObject {
    
    static let shared = ALF()
    
    private func urlString(subUrl: String) -> String {
        return "https://cat-fact.herokuapp.com/\(subUrl)"
    }
    
    
    
    /****************************  ***********************************/
    /******************* GET Method with PARAMS **********************/
    /****************************  ***********************************/
    
    func doGetData(parameters: Dictionary<String, Any>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.getMethodWithParams(parameters: parameters as Dictionary<String, Any>, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func getMethodWithParams(parameters: Dictionary<String, Any>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        var headers: HTTPHeaders?
        
        if let token =  UserDefaults.standard.object(forKey: "accesstoken") as? String {
            headers = ["Content-Type" : "application/json", "accesstoken" : token]
        }else{
            headers = ["Content-Type" : "application/json"]
        }
        
        let manager = Session.default
        print(headers as Any)
        print(forMethod)
        manager.session.configuration.timeoutIntervalForRequest = 10
        print(parameters)
        manager.sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        manager.sessionConfiguration.urlCache?.removeAllCachedResponses()
        URLCache.shared.removeAllCachedResponses()
//        manager.sessionConfiguration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
//        NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
//        manager.session.configuration.urlCache?.removeAllCachedResponses()
        manager.request(forMethod, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                success(value as AnyObject)
            case .failure(let error):
                print(error)
                fail(error as AnyObject)
            }
            
        }
        
    }
    
    /******************* END OF GET Method with PARAMS **********************/
    
    
    /****************************  ***********************************/
    /******************* POST Method with PARAMS *********************/
    /****************************  ***********************************/
    
    func doPostData(parameters: Dictionary<String, Any>, method: String, success: @escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.postMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func postMethodWithParams(parameters: Dictionary<String, Any>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        var headers: HTTPHeaders?
        if let token =  UserDefaults.standard.object(forKey: "accesstoken") as? String {
            headers = [ "Content-Type" : "application/json", "Authorization" : token]
        }
        
        print(headers as Any)
        let manager = Session.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        URLCache.shared.removeAllCachedResponses()
        manager.request(forMethod, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                success(value as AnyObject)
            case .failure(let error):
                print(error)
                fail(error as AnyObject)
            }
        }
        
    }
    
    func updatedoPostData(parameters: Dictionary<String, Any>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.updatepostMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func updatepostMethodWithParams(parameters: Dictionary<String, Any>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        var headers: HTTPHeaders?
        
        print(headers as Any)
        let manager = Session.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        URLCache.shared.removeAllCachedResponses()
        manager.request(forMethod, method: .post, parameters: parameters,  headers: headers).responseString { response in
            switch response.result {
            case .success(let value):
                success(value as AnyObject)
            case .failure(let error):
                print(error)
                fail(error as AnyObject)
            }
        }
        
    }
    
    
    /******************* END OF POST Method with PARAMS **********************/
    
    
    /****************************  ***********************************/
    /*************** POST Method with PARAMS and IMAGE *******************/
    /****************************  ***********************************/
    
//    func doPostDataWithImage(parameters: [String:String], method: String, image: UIImage?, image_name: String, fileType: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
//        
//        self.postMethodWithParamsAndImage(parameters: parameters, forMethod: self.urlString(subUrl: method), image: image, image_name: image_name, fileType: fileType,success: success, fail: fail)
//    }
    
    
//    private func postMethodWithParamsAndImage(parameters: [String:String], forMethod: String, image: UIImage?, image_name: String, fileType: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
//
//        let manager = Session.default
//        manager.session.configuration.timeoutIntervalForRequest = 10
//
//        var headers: HTTPHeaders?
//
//        if let token =  UserDefaults.standard.object(forKey: "accesstoken") as? String {
//            headers = ["Content-Type" : "application/json", "Authorization" : token]
//        }else{
//            headers = ["Content-Type" : "application/json"]
//        }
//
//        print(headers as Any)
//        AF.upload(multipartFormData: { multiPart in
//            print(parameters)
//            print(image as Any)
//            if image != nil {
//
//                let imgData = (image?.jpeg(.low))!
//
//                print(imgData.count)
//                let exten = image_name
//                let mimetype: String = exten.mimeType()
//                multiPart.append(imgData, withName: "file", fileName: "\(image_name)", mimeType: mimetype)
//
//            }
//            if !(parameters.isEmpty) {
//                for (key, value) in parameters {
//                    print("key: \(key) -> val: \(value)")
//                    if let dic = value as? Dictionary<String,Any>{
//                        print(key)
//                        print(value)
//                        do {
//                            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
//                            let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//
//                            multiPart.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
//                        } catch {
//                            print(error.localizedDescription)
//                        }
//
//                    }else{
//                        multiPart.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
//                    }
//
//                }
//            }
//            print(multiPart)
//        }, to: forMethod, method: .post, headers: headers)
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            .responseJSON { (response) in
//                switch response.result {
//                case .success(let value):
//                    success(value as AnyObject)
//                case .failure(let error):
//                    print(error)
//                    fail(error as AnyObject)
//                }
//            }
//
//    }
    
//    func doPostDataWithMedia(parameters: [String:String], method: String, data: URL?, name: String, fileType: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
//
//        self.postMethodWithParamsAndMedia(parameters: parameters, forMethod: self.urlString(subUrl: method), filename: data, name: name, fileType: fileType, success: success, fail: fail)
//    }
    
//    private func postMethodWithParamsAndMedia(parameters: [String:String], forMethod: String, filename: URL?, name: String, fileType: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
//
//        let manager = Session.default
//        var headers: HTTPHeaders?
//
//        if let token =  UserDefaults.standard.object(forKey: "accesstoken") as? String {
//            headers = ["Content-Type" : "application/json", "Authorization" : token]
//        }else{
//        headers = ["Content-Type" : "application/json"]
//                }
//        print(filename!)
//        //        if Util.isLoggedIn() {
//        //            headers = ["accesstoken": Util.getUser()!.token]
//        //        }
//        AF.upload(multipartFormData: { multiPart in
//            if let urlString = filename {
//                let contentData = try! Data(contentsOf: urlString.asURL())
//                let data : Data = contentData
//                let exten = name
//                let mimetype: String = exten.mimeType()
//                multiPart.append(data, withName: "post_image", fileName: name, mimeType: mimetype)
//                for (key, value) in parameters {
//                    multiPart.append(((value as? String)?.data(using: .utf8))!, withName: key)
//                }
//            }
//            if !(parameters.isEmpty) {
//                for (key, value) in parameters {
//                    print("key: \(key) -> val: \(value)")
//                    if let dic = value as? Dictionary<String,Any>{
//                        print(key)
//                        print(value)
//                        do {
//                            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
//                            let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//                            //                        multipartFormData.append(jsonData, withName: key)
//                            multiPart.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
//                        } catch {
//                            print(error.localizedDescription)
//                        }
//
//                    }else{
//                        multiPart.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
//                    }
//
//                }
//            }
//            print(multiPart)
//
//        }, to: forMethod, method: .post, headers: headers)
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            .responseJSON { (response) in
//                switch response.result {
//                case .success(let value):
//                    success(value as AnyObject)
//                case .failure(let error):
//                    print(error)
//                    fail(error as AnyObject)
//                }
//            }
//        manager.request(forMethod, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//
//            switch response.result {
//            case .success(let value):
//                success(value as Any)
//            case .failure(let error):
//                print(error)
//                fail(error as Any)
//            }
//        }
        
//    }
        
    //    func doPostDataWithMedia(parameters: [String:String], method: String, data: URL?,name: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
    //
    //        self.postMethodWithParamsAndMedia(parameters: parameters, forMethod: self.urlString(subUrl: method), filename: data, name: name, success: success, fail: fail)
    //    }
    //
    //    private func postMethodWithParamsAndMedia(parameters: [String:String], forMethod: String, filename: URL?,name: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
    //
    //        let manager = Session.default
    //        var headers: HTTPHeaders?
    //
    //        AF.upload(multipartFormData: { multiPart in
    //            print(parameters)
    //            print(filename as Any)
    //            var data: Data?
    //            do {
    ////                data = try NSData(contentsOf: filename!) as Data
    //                data = try NSData(contentsOf: filename!, options: [.dataReadingMapped, .uncached, .mappedIfSafe]) as Data
    //                print(data!)
    //            } catch {
    //                print(error)
    //            }
    //
    //            if data != nil {
    //                multiPart.append(data!, withName: name)
    //                //            multipartFormData.append(filename!, withName: "filename")
    //                //            multiPart.append(data!, withName: name, fileName: "\(name).txt", mimeType: "text/plain")
    //
    //            }
    //            if !(parameters.isEmpty) {
    //                for (key, value) in parameters {
    //                    print("key: \(key) -> val: \(value)")
    //                    if let dic = value as? Dictionary<String,AnyObject>{
    //                        print(key)
    //                        print(value)
    //                        do {
    //                            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
    //                            let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
    //                            //                        multipartFormData.append(jsonData, withName: key)
    //                            multiPart.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
    //                        } catch {
    //                            print(error.localizedDescription)
    //                        }
    //
    //                    }else{
    //                        multiPart.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
    //                    }
    //
    //                }
    //            }
    //            print(multiPart)
    //        }, to: forMethod, method: .post , headers: headers)
    //        .uploadProgress(queue: .main, closure: { progress in
    //            //Current upload progress of file
    //            print("Upload Progress: \(progress.fractionCompleted)")
    //        })
    //        .responseJSON { (response) in
    //            switch response.result {
    //            case .success(let value):
    //                success(value as Any)
    //            case .failure(let error):
    //                print(error)
    //                fail(error as Any)
    //            }
    //        }
    //
    //    }
    /******************* END OF POST Method with PARAMS and IMAGE **********************/
    
    /****************************  ***********************************/
    /******************* PUT Method with PARAMS *********************/
    /****************************  ***********************************/
    
    func doPutData(parameters: Dictionary<String, Any>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.putMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func putMethodWithParams(parameters: Dictionary<String, Any>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        var headers: HTTPHeaders?
        if let token =  UserDefaults.standard.object(forKey: "accesstoken") as? String {
            headers = ["Content-Type" : "application/json", "Authorization" : token]
        }
        
        print(headers as Any)
        let manager = Session.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        URLCache.shared.removeAllCachedResponses()
        manager.request(forMethod, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                success(value as AnyObject)
            case .failure(let error):
                print(error)
                fail(error as AnyObject)
            }
        }
        
    }
    
    func doPutDataWithoutAccessToken(parameters: Dictionary<String, Any>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.putMethodWithParamsWithoutAccessToken(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func putMethodWithParamsWithoutAccessToken(parameters: Dictionary<String, Any>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        var headers: HTTPHeaders?
        
        print(headers as Any)
        let manager = Session.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        URLCache.shared.removeAllCachedResponses()
        manager.request(forMethod, method: .put, parameters: parameters,  headers: headers).responseString { response in
            switch response.result {
            case .success(let value):
                success(value as AnyObject)
            case .failure(let error):
                print(error)
                fail(error as AnyObject)
            }
        }
        
    }
    
    
    /******************* END OF PUT Method with PARAMS **********************/
    
    
    
    /****************************  ***********************************/
    /******************* DELETE Method with PARAMS *********************/
    /****************************  ***********************************/
    
    
    func doDeleteData(parameters: Dictionary<String, Any>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.deleteMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func deleteMethodWithParams(parameters: Dictionary<String, Any>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        var headers: HTTPHeaders?
        if let token =  UserDefaults.standard.object(forKey: "accesstoken") as? String {
            headers = ["Content-Type" : "application/json", "Authorization" : token]
        }
        
        print(headers as Any)
        let manager = Session.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        URLCache.shared.removeAllCachedResponses()
        manager.request(forMethod, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                success(value as AnyObject)
            case .failure(let error):
                print(error)
                fail(error as AnyObject)
            }
        }
        
    }
    
    func doDeleteDataWithoutAccessToken(parameters: Dictionary<String, Any>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.deleteMethodWithParamsWithoutAccessToken(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func deleteMethodWithParamsWithoutAccessToken(parameters: Dictionary<String, Any>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        var headers: HTTPHeaders?
        
        print(headers as Any)
        let manager = Session.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        URLCache.shared.removeAllCachedResponses()
        manager.request(forMethod, method: .delete, parameters: parameters,  headers: headers).responseString { response in
            switch response.result {
            case .success(let value):
                success(value as AnyObject)
            case .failure(let error):
                print(error)
                fail(error as AnyObject)
            }
        }
        
    }
    
    /******************* END OF DELETE Method with PARAMS **********************/
    
    func validateResponse(response: Any) -> Bool {
        if let res = response as? Dictionary<String,Any> {
            if let status = res["status"] as? Int {
                if status == 200 {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
        
    }
    func validateStatus(response: AnyObject) -> Int {
        if let res = response as? Dictionary<String,Any> {
            if let status = res["status"] as? Int {
                return status
            }
        }
        return 404
    }
    
}

