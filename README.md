# **Technical Programming Interview Study Guide**

> If you would like to create your own sample problems, paste this template into your GPT chatline: 
```md
Using the prompt at the provided link, create a new practice problem for me: https://raw.githubusercontent.com/jstngoulet/practice-problems/refs/heads/main/GPTPrompt.md
```

## 📚 **1. Data Structures**

Data structures form the backbone of most coding interview problems. Below are some common data structures you should understand thoroughly:

### **Arrays and Strings**
- **Array manipulation** (sorting, searching, reversing, finding maximum/minimum, etc.)
- **String manipulation** (concatenation, substring, palindromes, anagrams)
- **Common problems**: 
  - Find the longest/shortest subarray
  - Substring problems (e.g., longest unique substring)
  - Two-pointer techniques

### **Linked Lists**
- **Singly and Doubly Linked Lists**
- Operations: insert, delete, reverse, detect cycles
- **Common problems**:
  - Merge two sorted lists
  - Detect cycles (Floyd’s cycle-finding algorithm)
  - Find the middle element of the list
  - Remove N-th node from the end

### **Stacks and Queues**
- **Stacks**: LIFO (Last In First Out)
- **Queues**: FIFO (First In First Out)
- **Common problems**:
  - Balanced parentheses
  - Implementing a queue using stacks
  - Implementing a stack using queues
  - BFS (Breadth-First Search)

### **Hash Maps and Sets**
- **Hash Maps**: key-value pairs
- **Sets**: store unique elements
- **Common problems**:
  - Finding duplicates
  - Frequency counting (e.g., first non-repeating character)
  - Two-sum problem
  - Anagrams

### **Trees**
- **Binary Tree**: nodes with at most two children (left and right)
- **Binary Search Tree (BST)**: left child is smaller, right child is larger
- **Tree traversal**: In-order, Pre-order, Post-order
- **Common problems**:
  - Find the height of the tree
  - Level-order traversal (BFS)
  - Lowest common ancestor
  - Serialize and deserialize a binary tree

### **Heaps**
- **Min-Heap** and **Max-Heap**
- Priority queues
- **Common problems**:
  - Kth largest/smallest element
  - Merge k sorted lists

### **Graphs**
- **Representation**: Adjacency matrix, adjacency list
- **Traversal algorithms**:
  - Depth-First Search (DFS)
  - Breadth-First Search (BFS)
  - Shortest path (Dijkstra’s, Bellman-Ford, A*)
  - Topological sorting (for Directed Acyclic Graphs)

---

## 📄 **2. Algorithms**

A solid understanding of common algorithms is crucial. Be sure to study the following:

### **Sorting and Searching**
- **Sorting algorithms**:
  - Quick Sort (average O(n log n), worst-case O(n^2))
  - Merge Sort (O(n log n))
  - Bubble Sort, Insertion Sort (O(n^2) for both)
  - Heap Sort (O(n log n))
  - Counting Sort (O(n))
- **Searching**:
  - Binary Search (O(log n) on sorted data)
  - Linear Search (O(n))

### **Dynamic Programming (DP)**
- **Identify overlapping subproblems and optimal substructure**
- Common patterns:
  - Fibonacci sequence
  - Knapsack problem
  - Longest common subsequence
  - Coin change problem
  - Matrix chain multiplication
- **Memoization** vs **Tabulation** (Top-down vs Bottom-up)

### **Recursion**
- Understand **base cases** and **recursive calls**
- **Common problems**:
  - Factorial calculation
  - Permutations and combinations
  - Tower of Hanoi

### **Greedy Algorithms**
- Make locally optimal choices at each step
- Common problems:
  - Activity selection problem
  - Fractional knapsack problem
  - Huffman encoding

### **Backtracking**
- Try all possibilities and backtrack when a solution path does not work
- Common problems:
  - N-Queens problem
  - Sudoku solver
  - Permutations and combinations

### **Divide and Conquer**
- Divide the problem into smaller subproblems and combine the results
- **Common problems**:
  - Merge sort
  - Quick sort
  - Binary search

---

## 📐 **3. System Design**

A solid understanding of **system design** is essential for high-level interviews, especially for companies like Google, Amazon, and Microsoft.

### **Key Concepts**:
- **Scalability**: Handling an increasing load
- **Load balancing**: Distributing traffic across servers
- **Caching**: Reducing load on databases
- **Databases**: SQL vs NoSQL, indexing, normalization vs denormalization
- **Microservices architecture**: Decoupling components into independent services
- **CAP theorem**: Consistency, Availability, Partition tolerance
- **Message Queues**: Kafka, RabbitMQ, etc.

### **Design Problems**:
- Design a URL shortening service (like Bitly)
- Design a file storage system (like Dropbox or Google Drive)
- Design a social media platform (like Twitter)
- Design a real-time chat application (like WhatsApp)

---

## 💡 **4. Problem-Solving Strategies**

Here are a few key strategies for tackling coding problems:

### **Understand the Problem**
- Clarify any ambiguities before starting to code
- Break down the problem into smaller components
- Identify edge cases and constraints

### **Plan Your Approach**
- Consider brute force solutions first, then optimize
- Look for patterns in the problem (e.g., sliding window, two pointers, dynamic programming)

### **Write Pseudocode**
- Outline your algorithm in plain English before diving into code
- This helps prevent mistakes and makes your thought process clear to the interviewer

### **Test Edge Cases**
- Consider empty inputs, very large inputs, and boundary cases
- Think of cases that might break your solution (e.g., single-element arrays, null values, duplicates)

### **Optimize and Refactor**
- Once your solution works, think about time complexity (O(n), O(log n), etc.) and optimize
- Look for places to improve readability and maintainability

---

## 🧑‍💻 **5. Practice Resources**

### **LeetCode** 
- Offers a wide range of coding problems from basic to advanced topics

### **HackerRank**
- Good for algorithm challenges and also system design mock interviews

### **CodeSignal**
- Focus on practice questions and interview simulations

### **Cracking the Coding Interview** (Book)
- Contains a vast collection of coding questions and explanations with solutions

### **Pramp** (Mock Interviews)
- Provides free mock technical interviews with peers

### **InterviewBit**
- Excellent for interview preparation, including system design and data structures

---

## 📅 **6. Interview Tips**

### **During the Interview:**
- **Think out loud**: Explain your thought process as you work through the problem. It helps interviewers understand your approach.
- **Ask clarifying questions**: If something is unclear, ask questions. It shows you're thinking critically.
- **Start with a brute force solution**: It’s better to start with something simple and improve upon it than to get stuck in finding the perfect solution right away.
- **Code and test incrementally**: Write a small part of the solution, test it, and build on that.
- **Communicate your trade-offs**: If you're deciding between two approaches, explain why one might be better in terms of time or space complexity.

### **Post-interview**:
- Send a thank-you note: Always express your appreciation for the opportunity and the interviewer's time.
- Reflect on your performance: Identify areas for improvement.

---

## 📚 **7. Final Review**

Before the interview, review:
- **Key algorithms** (sorting, searching, recursion, dynamic programming)
- **Common data structures** (arrays, strings, hash maps, trees, graphs)
- **System design principles** (scalability, caching, distributed systems)
- **Practice problems** on platforms like LeetCode, HackerRank, and InterviewBit

Make sure you’re comfortable discussing **time complexity** (Big O notation) and **space complexity** for each solution you come up with.

---
