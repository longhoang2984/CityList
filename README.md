
# The Cities

The City List app with prefix filter by city's name

#### Architecture
MVVM + RxSwift

#### Algorithm
Trie Data Source (Prefix Tree) is an efficient information retrieval data structure. Using Trie, search complexities can be brought to optimal limit (key length). 
If we store keys in a binary search tree, a well balanced BST will need time proportional to M * log N, where M is the maximum string length and N is the number of keys in the tree. 
Using Trie, we can search the key in O(M) time. However, the penalty is on Trie storage requirements - [read more](https://awesomeopensource.com/project/elangosundar/awesome-README-templates)
