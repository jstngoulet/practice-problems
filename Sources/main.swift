// The Swift Programming Language
// https://docs.swift.org/swift-book

typealias ProblemExec = (problem: Problem, enabled: Bool)

let problems: [ProblemExec] = [
    (AddDigitsUntilOne(), false),
    (AddDecimalStrings(), false),
    (AnagramInspector(), false),
    (BoggleSolver(), false),
    (ClockAngles(), false),
    (ContainsDuplicate(), false),
    (CurrencyConverter(), false),
    (DailyTemperatures(), false),
    (DeflatedDisks(), false),
    (DetermineIfCrosswordGrid(), false),
    (DetermineIfPalindrome(), false),
    (FactorialCalculation(), false),
    (FirstNonRepeatingString(), false),
    (FirstUniqueCharacter(), false),
    (GroupAnagrams(), false),
    (IntersetingLinkedLists(), false),
    (LongestConsecutiveSequence(), false),
    (LongestEqualZeroOneSubarray(), false),
    (LongestRepeatingCharacterReplacement(), false),
    (LongestSubstring(), false),
    (LongestSubstringWithKDistinct(), false),
    (LongestSubstringWithoutRepeats(), false),
    (LowestCommonAncestor(), false),
    (MaximalRectangle(), true),
    (MaxSubarraySum(), false),
    (Merge2Arrays(), false),
    (Merge2Lists(), false),
    (MiddleOfLinkedList(), false),
    (MinimumWindowSubstring(), false),
    (RotaryLock(), false),
    (RotaryLock2(), false),
    (SingleNumber(), false),
    (Sorting(), false),
    (SpiralOrderMatrix(), false),
    (SubarraySumEqualsK(), false),
    (SubarraySumZero(), false),
    (TowerOfHanoi(), false),
    (TwoSumIndices(), false),
    (ValidParentheses(), false),
    (WaterFlowPathProblem(), false),
    (WordLadder(), false)
]


problems
    .filter({ $0.enabled })
    .forEach({ $0.problem.performTests() })