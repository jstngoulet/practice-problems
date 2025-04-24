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
    (LazyBartender(), false),
    (LongestConsecutiveSequence(), false),
    (LongestEqualZeroOneSubarray(), false),
    (LongestRepeatingCharacterReplacement(), false),
    (LongestSubarraySumEqualsK(), false),
    (LongestSubstring(), false),
    (LongestSubstringWithKDistinct(), false),
    (LongestSubstringWithoutRepeats(), false),
    (LongestSubstringWithoutRepeats2(), true),
    (LowestCommonAncestor(), false),
    (MaximalRectangle(), false),
    (MaxSubarraySum(), false),
    (Merge2Arrays(), false),
    (Merge2Lists(), false),
    (MiddleOfLinkedList(), false),
    (MinimumWindowSubstring(), false),
    (MinimumWindowSubstring2(), false),
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
    (ValidParentheses2(), false),
    (WaterFlowPathProblem(), false),
    (WordLadder(), false)
]


problems
    .filter({ $0.enabled })
    .forEach({ $0.problem.performTests() })