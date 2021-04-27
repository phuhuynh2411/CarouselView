//
//  SlideView.swift
//  TruyenTranh24h
//
//  Created by Huynh Tan Phu on 15/04/2021.
//

import SwiftUI

public struct CarouselView: View {
    @State var  items: [Carousel]
    
    /// auto change slide if is it true
    var isAutoChangeSlide: Bool = true
    
    /// number of seconds between each transtion
    var second: Int = 3
    
    /// show slide indicator if it is true
    var slideIndicator: Bool = true
    
    /// Carousel view's height
    var height: CGFloat = 190
    
    // A space between each slide
    var hStackSpacing:CGFloat = 9.0
    
    @State private var offset: CGPoint = .zero
    @State private var lastOffset: CGPoint = .zero
    @State private var index: Int = 1
    @State private var draggingTime = Date()
    private let screenWidth = UIScreen.main.bounds.width
    
    public init(items: [Carousel],
                isAutoChangeSlide: Bool = true,
                second: Int = 3,
                slideIndicator: Bool = true,
                height: CGFloat = 190,
                hStackSpacing: CGFloat = 9.0 ) {
        
        var tempItems: [Carousel] = items
        // Add the last item before the last item
        // Add the first item after last item
        if let lastItem = items.last, let firstItem = items.first  {
            tempItems.insert(lastItem, at: 0)
            tempItems.append(firstItem)
        }
        
        self._items = State(wrappedValue: tempItems)
        self.isAutoChangeSlide = isAutoChangeSlide
        self.second = second
        self.slideIndicator = slideIndicator
        self.height = height
        self.hStackSpacing = hStackSpacing
    }
    
    public var body: some View {
        VStack { // Use this view to move the slider to top
            
            ZStack (alignment: .bottom) {
                GeometryReader { geo in
                    // HStack for the image
                    
                    HStack(spacing: hStackSpacing) {
                        ForEach(items) { item in
                            CarouselItemlView(item: item)
                                .frame(width: geo.size.width)
                        }
                    }
                    .onAppear {
                        // Move to the first item
                        changeSide(newIndex: 1, withAni: false)
                        
                        // enable auto change slide
                        guard isAutoChangeSlide else {
                            return
                        }
                        // Auto go to next slide in three seconds
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            let delta = Date().timeIntervalSince(self.draggingTime)
                            if Int(delta) > self.second - 1 { // 3 seconds
                                changeSide(newIndex: self.index + 1)
                                self.draggingTime = Date()
                            }
                        }
                    }
                    .offset(x: offset.x, y: offset.y)
                    // Add drag events to the scrollview
                    .gesture(drag)
                }
                
                // Show slide indicators
                if self.slideIndicator {
                    HStack {
                        //Spacer()
                        ForEach((1...items.count - 2), id: \.self) { i in
                            Circle()
                                .foregroundColor(i == self.index ? Color("carouselSelectedIndicatorBg") : Color("carouselIndicatorBg") )
                                .frame(width: 7, height: 7)
                                .padding(.bottom)
                        }
                    }
                }
            }
            .frame(height: self.height)
            
            // Move the things above to top
            Spacer()
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { state in
                let distance = state.location.x - state.startLocation.x  + self.lastOffset.x
                
                self.offset =  CGPoint(x: distance, y: self.offset.y)
                
                // Update the dragging time
                self.draggingTime = Date()
            }
            .onEnded { state in
                var fallback = false
                
                withAnimation {
                    self.offset = CGPoint(x: self.offset.x + state.predictedEndLocation.x, y: self.offset.y)
                    
                    let delta = self.offset.x - self.lastOffset.x
                    
                    if abs(self.offset.x) > abs(self.lastOffset.x) , abs(delta) > screenWidth/2 {
                        index += 1
                    } else if abs(delta) - screenWidth > screenWidth/2  {
                        index -= 1
                    } else {
                        fallback = true
                    }
                }
                changeSide(newIndex: index, cycleSlide: fallback ? false : true)
            }
    }
    
    func changeSide(newIndex: Int, withAni: Bool = true, cycleSlide: Bool = true) {
        if withAni {
            withAnimation {
                setIndex(newIndex)
            }
        } else {
            setIndex(newIndex)
        }
        
        // Cycel the slider
        // if it's the last item, set the index to 1
        guard cycleSlide else { return }
        if newIndex == items.count - 1 {
            self.index = 1
            self.offset = CGPoint(x: -CGFloat(self.index) * UIScreen.main.bounds.size.width - (hStackSpacing * CGFloat(self.index)), y: self.offset.y)
        } else if newIndex == 0 {
            self.index = items.count - 2
            self.offset = CGPoint(x: -CGFloat(self.index) * UIScreen.main.bounds.size.width - (hStackSpacing * CGFloat(self.index)), y: self.offset.y)
        }
    
        // Save the last offset for the next times
        self.lastOffset = self.offset
    }
    
    func setIndex(_ newIndex: Int) {
        self.index = newIndex
        self.offset = CGPoint(x: -CGFloat(newIndex) * UIScreen.main.bounds.size.width - (hStackSpacing * CGFloat(newIndex)), y: self.offset.y)
        
        // Save the last offset for the next times
        self.lastOffset = self.offset
    }
    
}
