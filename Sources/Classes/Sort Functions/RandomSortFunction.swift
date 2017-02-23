//
//  RandomSortFunction.swift
//  Spruce
//
//  Created by Jackson Taylor on 11/15/16.
//  Copyright (c) 2017 WillowTree, Inc.

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

open class RandomSortFunction: SortFunction {
    
    let interObjectDelay: TimeInterval
    
    public init(interObjectDelay: TimeInterval) {
        self.interObjectDelay = interObjectDelay
    }
    
    open func getTimeOffsets(view: UIView, recursiveDepth: Int) -> [SpruceTimedView] {
        var subviews = view.getSubviews(recursiveDepth: recursiveDepth)
        subviews.shuffle()
        
        var timedViews: [SpruceTimedView] = []
        var currentTimeOffset: TimeInterval = 0.0
        for subview in subviews {
            let timedView = SpruceTimedView(spruceView: subview, timeOffset: currentTimeOffset)
            timedViews.append(timedView)
            currentTimeOffset += interObjectDelay
        }
        return timedViews
    }
}

// Array Shuffle:
// http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
