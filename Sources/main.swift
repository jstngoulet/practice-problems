// The Swift Programming Language
// https://docs.swift.org/swift-book

typealias ProblemExec = (problem: Problem, enabled: Bool)

let problems: [ProblemExec] = [
    (AnagramInspector(), false),
    (BoggleSolver(), false),
    (ClockAngles(), false),
    (CurrencyConverter(), false),
    (AddDigitsUntilOne(), false),
    (DetermineIfPalindrome(), false),
    (DetermineIfCrosswordGrid(), false),
    (DeflatedDisks(), false),
    (FactorialCalculation(), false),
    (FirstNonRepeatingString(), false),
    (FirstUniqueCharacter(), false),
    (GroupAnagrams(), false),
    (IntersetingLinkedLists(), false),
    (LongestConsecutiveSequence(), false),
    (LongestSubstring(), false),
    (lowestCommonAncestor(), false),
    (MaxSubarraySum(), false),
    (Merge2Arrays(), false),
    (Merge2Lists(), false),
    (MiddleOfLinkedList(), false),
    (RotaryLock(), false),
    (RotaryLock2(), false),
    (Sorting(), false),
    (SubarraySumEqualsK(), false),
    (SpiralOrderMatrix(), true),
    (TowerOfHanoi(), false),
    (ValidParentheses(), false),
    (WordLadder(), false)
]

problems
    .filter({ $0.enabled })
    .forEach({ $0.problem.performTests() })