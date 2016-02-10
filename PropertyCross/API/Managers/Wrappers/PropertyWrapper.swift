//
//  PropertyWrapper.swift
//  PropertyCross
//
//  Created by Master on 10/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

import Foundation

class PropertyWrapper: BaseWrapper {
    
    func searchPropertyByLocation(longitud: Double, latitud: Double, alquiler: Bool, venta: Bool, completionHandler: ((property: Property?) -> Void)) {
        var accessToken = UserDefaults.getAccessToken;
        var propertyRequest: PropertyRequest = PropertyRequest();
        propertyRequest.longitud = longitud;
        propertyRequest.latitud = latitud;
        propertyRequest.alquiler = alquiler;
        propertyRequest.venta = venta;
        
        var request = super.createRequestForServiceandHttpMethodandModel("propiedad/buscar", "POST", propertyRequest);
        request.addValueforHTTPHeaderField("Bearer \(accessToken)", "Authorization");
        
        super.runRequestwithCompletionHandler(request, completionHandler: { (response, error) in
            if (error) {
                completionHandler(nil);
            }
            else {
                completionHandler(response);
            }
        })
    }

}

