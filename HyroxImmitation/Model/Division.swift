//
//  Division.swift
//  HyroxImmitation
//
//  Created by Marina Lunts on 29.04.26.
//


enum Division: String, CaseIterable, Identifiable {
    case singleMale = "Single Male"
    case singleFemale = "Single Female"
    case doubleMale = "Double Male"
    case doubleFemale = "Double Female"
    case doubleMixed = "Double Mixed"

    var id: String { rawValue }

    var shortLabel: String {
        switch self {
        case .singleMale: "Single M"
        case .singleFemale: "Single F"
        case .doubleMale: "Double M"
        case .doubleFemale: "Double F"
        case .doubleMixed: "Double Mixed"
        }
    }

    var isDouble: Bool {
        self == .doubleMale || self == .doubleFemale || self == .doubleMixed
    }

    var isMaleWeights: Bool {
        self == .singleMale || self == .doubleMale
    }

    var isFemaleWeights: Bool {
        self == .singleFemale || self == .doubleFemale
    }
}