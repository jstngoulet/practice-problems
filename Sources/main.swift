// The Swift Programming Language
// https://docs.swift.org/swift-book

typealias ProblemExec = (problem: Problem, enabled: Bool)

let problems: [ProblemExec] = [
    (AddDigitsUntilOne(), false),
    (AnagramInspector(), false),
    (BoggleSolver(), false),
    (ClockAngles(), false),
    (ContainsDuplicate(), false),
    (CurrencyConverter(), false),
    (DailyTemperatures(), true),
    (DeflatedDisks(), false),
    (DetermineIfCrosswordGrid(), false),
    (DetermineIfPalindrome(), false),
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
    (SpiralOrderMatrix(), false),
    (SubarraySumEqualsK(), false),
    (SubarraySumZero(), false),
    (TowerOfHanoi(), false),
    (ValidParentheses(), false),
    (WordLadder(), false)
]


problems
    .filter({ $0.enabled })
    .forEach({ $0.problem.performTests() })