//
//  Debouncer.swift
//  App
//
//  Created by Kai Wang on 5/3/22.
//
// ref: https://onmyway133.com/posts/how-to-do-throttle-and-debounce-using-dispatchworkitem-in-swift/

import Foundation

public class Debouncer {
    private let delay: TimeInterval
    private var workItem: DispatchWorkItem?

    public init(delay: TimeInterval) {
        self.delay = delay
    }

    /// Trigger the action after some delay
    public func run(action: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem!)
    }
}
