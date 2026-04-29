import SwiftUI

struct ResultsView: View {
    let results: [StationResult]
    let totalTime: TimeInterval
    let division: Division
    let splitStations: Bool
    @Environment(\.dismiss) private var dismiss

    private var totalRunTime: TimeInterval {
        results.filter { $0.station.type == .run }.reduce(0) { $0 + $1.duration }
    }

    private var totalWorkoutTime: TimeInterval {
        results.filter { $0.station.type == .workout }.reduce(0) { $0 + $1.duration }
    }

    var body: some View {
        List {
            Section("Summary") {
                HStack {
                    Text("Division")
                    Spacer()
                    Text(division.rawValue)
                        .foregroundStyle(.secondary)
                }
                SummaryRow(label: "Total Time", time: totalTime, color: .primary)
                SummaryRow(label: "Total Run Time", time: totalRunTime, color: .blue)
                SummaryRow(label: "Total Workout Time", time: totalWorkoutTime, color: .orange)
            }

            Section("Stations") {
                ForEach(results) { result in
                    HStack {
                        Image(systemName: result.station.type == .run ? "figure.run" : "figure.strengthtraining.functional")
                            .foregroundStyle(result.station.type == .run ? .blue : .orange)
                            .frame(width: Constants.Layout.iconWidth)

                        VStack(alignment: .leading) {
                            Text(result.station.name)
                                .font(.body.bold())
                            Text(result.station.adjustedDetail(split: splitStations))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text(formatTime(result.duration))
                            .font(.body.monospaced())
                    }
                }
            }
        }
        .navigationTitle("Results")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    let sampleResults = hyroxStations.prefix(4).map { station in
        StationResult(id: station.id, station: station, duration: Double.random(in: 120...360))
    }
    NavigationStack {
        ResultsView(results: sampleResults, totalTime: 900, division: .singleFemale, splitStations: false)
    }
}

private struct SummaryRow: View {
    let label: String
    let time: TimeInterval
    let color: Color

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(formatTime(time))
                .font(.title3.bold().monospaced())
                .foregroundStyle(color)
        }
    }
}
