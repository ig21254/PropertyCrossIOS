//
//  PropertyWrapper.swift
//  PropertyCross
//
//  Created by Master on 10/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

import Foundation

class PropertyWrapper: BaseWrapper {
    
    
    // PROPERTY MANAGEMENT
    func searchPropertyWithRequest(propertyRequest: PropertyRequest, completionHandler: ((propertySearch: PropertySearchResponse?) -> Void)) {
        let accessToken = UserDefaults.getAccessToken();
        
        let request = super.createRequestForService("propiedad/buscar", andHttpMethod: "POST", andModel: propertyRequest);
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField:"Authorization");
        
        super.runRequest(request, withCompletionHandler: { (response, apiError) in
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
        
        super.runRequest(request, withCompletionHandler: { (response, apiError) in
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
    
    func commentPropertyWithRequest(request: CommentRequest, id: NSString, completionHandler: ((commentResponse: CommentResponse?) -> Void)) {
        let accessToken = UserDefaults.getAccessToken();
        
        let request = super.createRequestForService("propiedad/\(id)/comentar", andHttpMethod: "DELETE", andModel: request);
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField:"Authorization");
        
        super.runRequest(request, withCompletionHandler: { (response, apiError) in
            if ((apiError) != nil) {
                completionHandler(commentResponse: nil);
            }
            else {
                do {
                    let resp: CommentResponse = try CommentResponse.init(dictionary: response);
                    completionHandler(commentResponse: resp);
                } catch {
                    print("\(error)");
                    completionHandler(commentResponse: nil);
                }
            }
        })
    }
    
    
    // FAVORITES MANAGEMENT
    func searchFavorites(completionHandler: ((propertySearch: PropertySearchResponse?) -> Void)) {
        let accessToken = UserDefaults.getAccessToken();
        
        let request = super.createRequestForService("favoritos", andHttpMethod: "GET", andModel: nil);
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField:"Authorization");
        
        super.runRequest(request, withCompletionHandler: { (response, apiError) in
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
    
    func deleteFavorite(id: NSString, completionHandler: ((propertySearch: PropertySearchResponse?) -> Void)) {
        let accessToken = UserDefaults.getAccessToken();
    
        let request = super.createRequestForService("favoritos/\(id)", andHttpMethod: "DELETE", andModel: nil);
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField:"Authorization");
    
        super.runRequest(request, withCompletionHandler: { (response, apiError) in
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
    
    func addFavorite(id: NSString, completionHandler: ((propertySearch: PropertySearchResponse?) -> Void)) {
        let accessToken = UserDefaults.getAccessToken();
        
        let request = super.createRequestForService("favoritos/\(id)", andHttpMethod: "POST", andModel: nil);
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField:"Authorization");
        
        super.runRequest(request, withCompletionHandler: { (response, apiError) in
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

