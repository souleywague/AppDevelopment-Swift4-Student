//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Souley on 13/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var answers: [Answer]
}

struct Answer {
    var text: String
    var value: Int
    
    enum PersonalityType {
        case dominant, impulsive, charming, sensible, fussy, shy
        
        var definition: String {
            switch self {
            case .dominant:
                return "Others see you as somebody they should \"handle with care\" You're seen as vain, self-centered, and who is extremely dominant. Others may admire you, wishing they could be more like you, but don't always trust you, hesitating to become too deeply involved with you."
            case .impulsive:
                return "Others see you as an exciting, highly volatile, rather impulsive personality; a natural leader, who's quick to make decisions, though not always the right ones. They see you bold and adventuresome, someone who will try anything once; someone who takes chances and enjoys adventure. They enjoy being in your company because of the excitement you radiate."
            case .charming:
                return "Others see you as fresh, lively, charming, amusing, and always interesting; someone who's constantly in the center of attention, but sufficiently well-balanced not to let it go to their head. They also see you as kind, considerate, and understanding; someone who'll always cheer them up and help them out."
            case .sensible:
                return "Others see you as sensible, cautious, careful and practical. They see you as clever, gifted, or talented, but modest. Not a person who makes friends too quickly or easily, but someone who's extremely loyal to friends you do make and who expect the same loyalty in return. Those who really get to know you realize it takes a lot to shake your trust in your friends, but equally that it takes you a long time to get over it if that trust is ever broken."
            case .fussy:
                return "Your friends see you as painstaking and fussy. They see you as very cautious, extremely careful... A slow and steady plodder. It'd really surprise them if you ever did something impulsively or on the spur of the moment, expecting you to examine everything carefully from every angle and then, usually decide against it. They think this reaction is caused partly by your careful nature."
            case .shy:
                return "People think you are shy, nervous, and indecisive someone who needs looking after, who always wants someone else to make the decisions and who doesn't want to get involved with anyone or anything. They see you as a worrier who always sees problems that don't exist. Some people think you're boring. Only those who know you well know that you aren't."
            }
        }
        
    }
}


