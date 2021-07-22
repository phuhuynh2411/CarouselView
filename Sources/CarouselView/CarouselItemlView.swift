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
    var height: CGFloat
    var borderRadius: CGFloat
    
    public var body: some View {
        GeometryReader { geo in
            HStack (alignment: .center){
                
                RemoteImageView(stringURL: item.stringURL)
                    .scaledToFill()
                    .frame(width: geo.size.width, height: self.height, alignment: .top)
                    .clipped()
                    .background(Color.secondary)
                    .cornerRadius(borderRadius)
                
            }
        }
    }
}
