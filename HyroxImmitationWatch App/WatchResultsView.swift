import SwiftUI

struct WatchResultsView: View {
    let results: [StationResult]
    let totalTime: TimeInterval
    let division: Division
    let splitStations: Bool
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            HStack {
                Text("Total")
                    .font(.subheadline)
                    .padding(5)
                Spacer()
                Text(formatTime(totalTime))
                    .font(.title3.bold().monospaced())
            }.listRowBackground(Color.clear)

            Section {
                ForEach(results) { result in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(result.station.name)
                                .font(.caption.bold())
                            Text(result.station.adjustedDetail(split: splitStations))
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text(formatTime(result.duration))
                            .font(.caption.monospaced())
                    }
                }
            }
            header: {
                Text("Stations")
                    .font(.subheadline)
                    .padding(5)
            }
        }
        .navigationTitle("Results")
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
    WatchResultsView(results: sampleResults, totalTime: 900, division: .singleFemale, splitStations: false)
}
