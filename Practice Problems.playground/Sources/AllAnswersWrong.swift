//
//  AllAnswersWrong.swift
//  
//
//  Created by Justin Goulet on 3/28/25.
//
import Foundation

class AllAnswersWrong: NSObject {
    
    func performTests() {
        print("Answers: \(getWrongAnswers(3, "ABA"))")
    }
    /**
     All Wrong:
     There's a multiple-choice test with N questions, numbered from to N.
     Each question has 2 answer options, labelled A and B. You know that the correct
     answer for the ith question is the ith character in the string C, which is
     either "A" or "B", but you want to get a score of 0 on this test by answering
     every question incorrectly.
     
     Your task is to implement the function getWrongAnswers(N, C)
     which returns a string with N characters, the ith of which is the answer
     you should give for question i in order to get it wrong (either "A" or "B").
     
     Example:
     N =        3
     C =        ABA
     Expected:  BAB
     
     Example:
     N =        5
     C =        BBBBB
     Expected:  AAAAA
     */
    func getWrongAnswers(_ N: Int, _ C: String) -> String {
        // Write your code here
        return String(C.map({ $0 == "A" ? "B" : "A"}))
    }
}
