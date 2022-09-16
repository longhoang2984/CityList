//
//  TrieNode.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 15/09/2022.
//

import Foundation

class TrieNode<K: Hashable, T: Hashable> {
    
    var value: T?
    var key: K?
    weak var parentNode: TrieNode?
    var children: [K: TrieNode] = [:]
    var isTerminating: Bool = false
    var isEmpty: Bool {
        return children.count == 0
    }
    
    /// Initialize
    /// - Parameters:
    ///     - key: The key that goes into the node
    ///     - value: The value that goes into the node
    ///     - parentNode: A reference to this node's parent
    init(key: K? = nil, value: T? = nil, parentNode: TrieNode? = nil) {
        self.key = key
        self.value = value
        self.parentNode = parentNode
    }
    
    /// Add a chil node to this node. If the child node is already present, return
    ///  - Parameters:
    ///     - value: the item to be added to this node
    ///     - key: the key for checking node exist in children or not
    ///     if not, store the node  into the children dictionary with key
    func add(key: K, value: T) {
        guard children[key] == nil else {
            return
        }
        children[key] = TrieNode(key: key, value: value, parentNode: self)
    }
}
