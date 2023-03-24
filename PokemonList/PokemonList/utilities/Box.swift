//
//  Box.swift
//  PokemonList
//
//  Created by Eda Barutçu on 23/03/23.
//  This class will use to do data binding

import Foundation

final class Box<T> {
    
    typealias Listener = (T) -> Void
    var listener : Listener?
    
    var value : T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
}
