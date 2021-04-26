//
//  SlideThumbnail.swift
//  TruyenTranh24h
//
//  Created by Huynh Tan Phu on 15/04/2021.
//

import SwiftUI
import RemoteImageView

public struct CarouselItemlView: View {
    @State var item: Carousel
    
    public var body: some View {
        GeometryReader { geo in
            RemoteImageView(stringURL: item.stringURL)
                .frame(width: geo.size.width, height: 190)
                .background(Color.secondary)
        }
    }
}
