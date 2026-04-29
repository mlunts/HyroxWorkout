import Foundation
import SwiftUI

@Observable
final class WorkoutViewModel {
    var division: Division = .singleMale
    var splitStations = false
    var currentStationIndex = 0
    var stationElapsedTime: TimeInterval = 0
    var totalElapsedTime: TimeInterval = 0
    var results: [StationResult] = []
    var isFinished = false

    private var stationStartDate = Date()
    private var workoutStartDate = Date()
    private var timer: Timer?

    var currentStation: Station {
        hyroxStations[currentStationIndex]
    }

    var stationProgress: String {
        "\(currentStationIndex + 1) / \(hyroxStations.count)"
    }

    var isLastStation: Bool {
        currentStationIndex == hyroxStations.count - 1
    }

    func start() {
        let now = Date()
        workoutStartDate = now
        stationStartDate = now
        stationElapsedTime = 0
        totalElapsedTime = 0
        results = []
        currentStationIndex = 0
        isFinished = false
        startTimer()
    }

    func nextStation() {
        let duration = Date().timeIntervalSince(stationStartDate)
        let result = StationResult(
            id: currentStationIndex,
            station: currentStation,
            duration: duration
        )
        results.append(result)

        if isLastStation {
            stopTimer()
            isFinished = true
        } else {
            currentStationIndex += 1
            stationStartDate = Date()
            stationElapsedTime = 0
        }
    }

    func finishEarly() {
        let duration = Date().timeIntervalSince(stationStartDate)
        let result = StationResult(
            id: currentStationIndex,
            station: currentStation,
            duration: duration
        )
        results.append(result)
        stopTimer()
        isFinished = true
    }

    func stop() {
        stopTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: Constants.Timer.updateInterval, repeats: true) { [weak self] _ in
            guard let self else { return }
            let now = Date()
            self.stationElapsedTime = now.timeIntervalSince(self.stationStartDate)
            self.totalElapsedTime = now.timeIntervalSince(self.workoutStartDate)
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

func formatTime(_ time: TimeInterval) -> String {
    let totalSeconds = Int(time)
    let hours = totalSeconds / Constants.Time.secondsPerHour
    let minutes = (totalSeconds % Constants.Time.secondsPerHour) / Constants.Time.secondsPerMinute
    let seconds = totalSeconds % Constants.Time.secondsPerMinute
    if hours > 0 {
        return String(format: "%d:%02d:%02d", hours, minutes, seconds)
    }
    return String(format: "%02d:%02d", minutes, seconds)
}
