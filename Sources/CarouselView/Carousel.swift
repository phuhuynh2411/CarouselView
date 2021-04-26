//
//  Carousel.swift
//  TruyenTranh24h
//
//  Created by Huynh Tan Phu on 20/04/2021.
//

import Foundation

struct Carousel: Identifiable, Decodable {
    let id: Int
    let stringURL: String
    
    init(id: Int, stringURL: String) {
        self.id = id
        self.stringURL = stringURL
    }
}
