//
//  Carousel.swift
//  TruyenTranh24h
//
//  Created by Huynh Tan Phu on 20/04/2021.
//

import Foundation

public struct Carousel: Identifiable, Decodable {
    public let id: Int
    public let stringURL: String
    
    public init(id: Int, stringURL: String) {
        self.id = id
        self.stringURL = stringURL
    }
}
