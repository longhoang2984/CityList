//
//  Trie.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 15/09/2022.
//

import Foundation

/// A trie data structure contaning City
/// Each node is a single
/// character of city name or country
class Trie {
    
    typealias Node = TrieNode<Character, CityModel>
    fileprivate var root: Node
    fileprivate var citiesCount: Int
    // The number of city in trie
    public var count: Int {
        return citiesCount
    }
    
    // Is the trie empty
    public var isEmpty: Bool {
        return citiesCount == 0
    }
    
    // Get all cities in the node
    public var cities: CitiesResponse {
        return citiesInSubtrie(rootNode: root, partialKey: "")
    }
    
    /// Initialize
    init() {
        root = Node()
        citiesCount = 0
    }
    
    /// Insert the city into the node with key
    /// - Parameters:
    ///     - key: The key for create prefix tree
    ///     - city: The city that goes into the  prefix tree's node
    func insert(key: String, city: CityModel) {
        // Check the key is empty or not
        // if Yes, return
        // or continue
        guard !key.isEmpty else {
            return
        }
        
        // set current node as a root
        var currentNode = root
        
        // Lowercase the key and then remove \ to get correct string (Ex: "\' t")
        let name = key.lowercased().replacingOccurrences(of: "\\", with: "")
        
        // Create a loop
        for character in name {
            // Check if the character has node or not
            // If yes, set current node is the node
            // If no, create new node and set current node
            // as a children node
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                currentNode.add(key: character, value: city)
                currentNode = currentNode.children[character]!
            }
        }
        guard !currentNode.isTerminating else { return }
        citiesCount += 1
        currentNode.isTerminating = true
    }
    
    /// Find the last node which match with prefix
    private func findLastNodeOf(prefix: String) -> Node? {
        var currentNode = root
        for character in prefix {
            guard let childNode = currentNode.children[character] else {
                return nil
            }
            currentNode = childNode
        }
        
        return currentNode
    }
    
    /// Get all cities in the subtrie from the root node
    /// - Parameters:
    ///     - rootNode: the begining node
    ///     - partialKey: the partial for get city list in the node
    fileprivate func citiesInSubtrie(rootNode: Node, partialKey: String) -> CitiesResponse {
        var cities: CitiesResponse = CitiesResponse()
        var previousKeys = partialKey
        if let key = rootNode.key {
            previousKeys.append(key)
        }
        if rootNode.isTerminating, let value = rootNode.value {
            cities.append(value)
        }
        for childNode in rootNode.children.values {
            let childCities = citiesInSubtrie(rootNode: childNode, partialKey: previousKeys)
            cities += childCities
        }
        return cities
    }
    
    /// Get all cities in the Trie from the trie
    ///  that matches with the prefix
    /// - Parameters:
    ///     - prefix: prefix string
    ///     - filteredCityList: the list of city from other sources ( Default is EMPTY )
    func findCitiesWithPrefix(_ prefix: String, filteredCityList: CitiesResponse = CitiesResponse()) -> CitiesResponse {
        var cities = CitiesResponse()
        let prefixLowerCased = prefix.lowercased()
        if let lastNode = findLastNodeOf(prefix: prefixLowerCased) {
            if lastNode.isTerminating, let value = lastNode.value {
                if filteredCityList.contains(where: { return $0 != value }) {
                    cities.append(value)
                }
            }
            for childNode in lastNode.children.values {
                var childCities = citiesInSubtrie(rootNode: childNode, partialKey: prefixLowerCased)
                if !filteredCityList.isEmpty {
                    childCities = childCities.filter { city in
                        return filteredCityList.contains(where: { return $0 != city })
                    }
                }
                cities += childCities
            }
        }
        
        return cities
    }
}
