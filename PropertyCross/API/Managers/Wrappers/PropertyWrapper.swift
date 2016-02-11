//
//  PropertyWrapper.swift
//  PropertyCross
//
//  Created by Master on 10/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

import Foundation

class PropertyWrapper: BaseWrapper {
    
    func searchPropertyByLocation(longitud: Double, latitud: Double, alquiler: Bool, venta: Bool, completionHandler: ((propertySearch: PropertySearchResponse?) -> Void)) {
        let accessToken = UserDefaults.getAccessToken;
        let propertyRequest: PropertyRequest = PropertyRequest();
        propertyRequest.longitud = longitud;
        propertyRequest.latitud = latitud;
        propertyRequest.alquiler = alquiler;
        propertyRequest.venta = venta;
        
        
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
    
    func searchPropertyByDirection(query: String, alquiler: Bool, venta: Bool, completionHandler: ((propertySearch: PropertySearchResponse?) -> Void)) {
        let accessToken = UserDefaults.getAccessToken;
        let propertyRequest: PropertyRequest = PropertyRequest();
        propertyRequest.alquiler = alquiler;
        propertyRequest.venta = venta;
        propertyRequest.query = query;
        
        
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
    
    static let sharedInstance = PropertyWrapper();

}

