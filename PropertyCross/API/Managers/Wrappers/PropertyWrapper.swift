//
//  PropertyWrapper.swift
//  PropertyCross
//
//  Created by Master on 10/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

import Foundation

class PropertyWrapper: BaseWrapper {
    
    func searchPropertyWithRequest(propertyRequest: PropertyRequest, completionHandler: ((propertySearch: PropertySearchResponse?) -> Void)) {
        let accessToken = UserDefaults.getAccessToken();
        
        let request = super.createRequestForService("propiedad/buscar", andHttpMethod: "POST", andModel: propertyRequest);
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField:"Authorization");
    
        //print("REQUEST: \(request)");
        
        super.runRequest(request, withCompletionHandler: { (response, apiError) in
            //print("RESPONSE: \(response)");
            if ((apiError) != nil) {
                completionHandler(propertySearch: nil);
            }
            else {
                do {
                    let searchResponse: PropertySearchResponse = try PropertySearchResponse.init(dictionary: response);
                    completionHandler(propertySearch: searchResponse);
                } catch {
                    print("\(error)");
                    completionHandler(propertySearch: nil);
                }
            }
        })
    }
    
    
    func searchPropertyDetails(id: NSString, completionHandler: ((propertySearch: PropertySearchResponse?) -> Void)) {
        let accessToken = UserDefaults.getAccessToken();
        
        let request = super.createRequestForService("propiedad/\(id)", andHttpMethod: "POST", andModel: nil);
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField:"Authorization");
        
        //print("REQUEST: \(request)");
        
        super.runRequest(request, withCompletionHandler: { (response, apiError) in
            //print("RESPONSE: \(response)");
            if ((apiError) != nil) {
                completionHandler(propertySearch: nil);
            }
            else {
                do {
                    let searchResponse: PropertySearchResponse = try PropertySearchResponse.init(dictionary: response);
                    completionHandler(propertySearch: searchResponse);
                } catch {
                    print("\(error)");
                    completionHandler(propertySearch: nil);
                }
            }
        })
    }
    
    static let sharedInstance = PropertyWrapper();

}

