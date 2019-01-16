//
//  NetworkHeadersAdapter.swift
//  Seat
//
//  Created by Gary Dos Santos on 29/1/18.
//  Copyright © 2018. All rights reserved.
//

import RxAlamofire
import Alamofire
import BaseRxApplication

final class NetworkHeadersAdapter: RequestAdapter {
    
    private var request = ExampleAPI.faqs

    init(request: ExampleAPI) {
        self.request = request
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        var log = "\nREQUEST -> \n - URL: \(request.path) \n - METHOD: \(request.method) \n - TIME: \(Date().toString())"
        urlRequest.setValue(APIHeaders.headerContentTypeValue, forHTTPHeaderField: APIHeaders.headerContentTypeKey)
        urlRequest.setValue(TranslatorManager.defaultLanguage(), forHTTPHeaderField: APIHeaders.headerAcceptedLanguage)
        
        if request.oauth {
            urlRequest.setValue("\(APIHeaders.headerBearerKey) eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJqcksweV9SSU5xSEVWMloxSHpVcWRDNTRFN3k5MVVkTm5BMHlmcVhqc2s4In0.eyJqdGkiOiJlNTdkYWMwYS0wYTRkLTQ1N2EtOTljMi1lZDcyODBhMjNkM2QiLCJleHAiOjE1MjAyNjkzNDUsIm5iZiI6MCwiaWF0IjoxNTIwMjY5MDQ1LCJpc3MiOiJodHRwczovL2F1dGgtay1zdW5oaWxsLmNvbS9hdXRoL3JlYWxtcy9zZWF0LW1vYmlsaXR5IiwiYXVkIjoic2VydmljZS1zZWF0LW1vYmlsaXR5Iiwic3ViIjoiNzYwZDYyY2UtZTI1OC00NzdkLTkzNDQtOWEzNGUyZTZhOTYwIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoic2VydmljZS1zZWF0LW1vYmlsaXR5IiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiMWIwOGYyOGItMjdjOC00Y2E3LThjODEtZWExMTA1YWRjMDJiIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyIqIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJyZWdpc3RlcmVkIiwiY3VzdG9tZXJfb3duZXIiXX0sInJlc291cmNlX2FjY2VzcyI6e30sImN1c3RvbWVySWQiOiJhNjk1N2UwZC1lNmE4LTQ2ZWItOWUzOS0xYmMxYjZhODIwMzkiLCJ1c2VySWQiOiI4MDk1ZTljOC04MzRmLTQ3MjUtYmVhNC1hYWNjMzQyMzg0ODciLCJlbWFpbCI6Im1vYmlsZSsxNEBiZXJlcHVibGljLmVzIn0.EGmIB2huPkCkb0eD2xVTH_eGxEqlQTGMiVhdKP3jdwYOjVNcgel9s5wDVWRS_AoO4sYp5VVh9CHA1eKcGfOGKHvVlGwKF67coz-n9570SHX-GU4ti1P7dFN4JquF-Bj5ZjXKAQ8uDpxFjIUDalLkG6Cy8-HpAOLA7xEzpoy--Xj0_ddLokkaLlbSmxBN5p-RzS_M1MiO9bdu2FZtaZUExYpKZh0AuN031zWrt1S9DOqybFgFidAg9J3mVIOAosaLP6kv4jO6pj4LSWvK3G9spCDYACw0-yuqtB53jCB45zfrn3oa8uLWA1y9_9xtnLqkW9s9q-xruk-QUVjYykDb_A", forHTTPHeaderField: APIHeaders.headerAuthorizationKey)
        }
        
//        switch request.logLevel {
//        case .parameters:
//            log = "\(log) \n - PARAMETERS: \(String(describing: request.parameters))"
//        case . headers:
//            log = "\(log) \n - HEADERS: \(String(describing:urlRequest.allHTTPHeaderFields))"
//        case .full:
//            log = "\(log) \n - PARAMETERS: \(String(describing: request.parameters)) \n - HEADERS: \(String(describing:urlRequest.allHTTPHeaderFields))"
//        case .none:
//            log = ""
//        }

        print(log + "\n")
        
        return urlRequest
    }
   
}
