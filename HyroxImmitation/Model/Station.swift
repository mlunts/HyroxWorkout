import Foundation

enum StationType {
    case run
    case workout
}

struct Station: Identifiable {
    let id: Int
    let name: String
    let detail: String
    let type: StationType

    func adjustedDetail(split: Bool) -> String {
        guard split, type == .workout else { return detail }
        switch name {
        case "SkiErg": return "500 m"
        case "Sled Push": return "25 m"
        case "Sled Pull": return "25 m"
        case "Burpee Broad Jumps": return "40 m"
        case "Rowing": return "500 m"
        case "Farmers Carry": return "100 m"
        case "Sandbag Lunges": return "50 m"
        case "Wall Balls": return "50 reps"
        default: return detail
        }
    }

    func info(for division: Division) -> String {
        switch name {
        case "SkiErg":
            return "Pull the handles down using arms and core"
        case "Sled Push":
            return "Push the sled across the floor — \(sledPushWeight(division))"
        case "Sled Pull":
            return "Pull the sled towards you with a rope — \(sledPullWeight(division))"
        case "Burpee Broad Jumps":
            return "Burpee followed by a forward jump, repeat for distance"
        case "Rowing":
            return "Row on the machine for distance"
        case "Farmers Carry":
            return "Carry kettlebells in each hand — \(farmersCarryWeight(division))"
        case "Sandbag Lunges":
            return "Walking lunges with a sandbag on your shoulder — \(sandbagWeight(division))"
        case "Wall Balls":
            return "Squat and throw the ball to the target — \(wallBallWeight(division))"
        default:
            if type == .run, id + 1 < hyroxStations.count {
                return "Run on the track before \(hyroxStations[id + 1].name)"
            }
            return ""
        }
    }

    private func sledPushWeight(_ division: Division) -> String {
        switch division {
        case .singleMale, .doubleMale: "152 kg"
        case .singleFemale, .doubleFemale: "102 kg"
        case .doubleMixed: "M 152 kg / F 102 kg"
        }
    }

    private func sledPullWeight(_ division: Division) -> String {
        switch division {
        case .singleMale, .doubleMale: "103 kg"
        case .singleFemale, .doubleFemale: "78 kg"
        case .doubleMixed: "M 103 kg / F 78 kg"
        }
    }

    private func farmersCarryWeight(_ division: Division) -> String {
        switch division {
        case .singleMale, .doubleMale: "2 x 24 kg"
        case .singleFemale, .doubleFemale: "2 x 16 kg"
        case .doubleMixed: "M 2x24 kg / F 2x16 kg"
        }
    }

    private func sandbagWeight(_ division: Division) -> String {
        switch division {
        case .singleMale, .doubleMale: "20 kg"
        case .singleFemale, .doubleFemale: "10 kg"
        case .doubleMixed: "M 20 kg / F 10 kg"
        }
    }

    private func wallBallWeight(_ division: Division) -> String {
        switch division {
        case .singleMale, .doubleMale: "6 kg ball"
        case .singleFemale, .doubleFemale: "4 kg ball"
        case .doubleMixed: "M 6 kg / F 4 kg"
        }
    }
}

struct StationResult: Identifiable {
    let id: Int
    let station: Station
    let duration: TimeInterval
}

let hyroxStations: [Station] = [
    Station(id: 0, name: "Run 1", detail: "1 km", type: .run),
    Station(id: 1, name: "SkiErg", detail: "1000 m", type: .workout),
    Station(id: 2, name: "Run 2", detail: "1 km", type: .run),
    Station(id: 3, name: "Sled Push", detail: "50 m", type: .workout),
    Station(id: 4, name: "Run 3", detail: "1 km", type: .run),
    Station(id: 5, name: "Sled Pull", detail: "50 m", type: .workout),
    Station(id: 6, name: "Run 4", detail: "1 km", type: .run),
    Station(id: 7, name: "Burpee Broad Jumps", detail: "80 m", type: .workout),
    Station(id: 8, name: "Run 5", detail: "1 km", type: .run),
    Station(id: 9, name: "Rowing", detail: "1000 m", type: .workout),
    Station(id: 10, name: "Run 6", detail: "1 km", type: .run),
    Station(id: 11, name: "Farmers Carry", detail: "200 m", type: .workout),
    Station(id: 12, name: "Run 7", detail: "1 km", type: .run),
    Station(id: 13, name: "Sandbag Lunges", detail: "100 m", type: .workout),
    Station(id: 14, name: "Run 8", detail: "1 km", type: .run),
    Station(id: 15, name: "Wall Balls", detail: "100 reps", type: .workout),
]
