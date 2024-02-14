//
//  MockURLSession.swift
//  VkSwiftAppTests
//
//  Created by User on 14.02.2024.
//

import XCTest
@testable import VkSwiftApp

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask
}

class URLSessionMock: URLSessionProtocol {

    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        completionHandler(data, response, error)
        return URLSessionDataTaskMock()
    }
}
    
class URLSessionDataTaskMock: URLSessionDataTask {
    override func resume() {}
}

