import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: WorkoutViewModel
    var settingsSync: SettingsSync

    var body: some View {
        NavigationStack {
            Form {
                Section("Division") {
                    Picker("Division", selection: $viewModel.division) {
                        ForEach(Division.allCases) { division in
                            Text(division.rawValue).tag(division)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                    .onChange(of: viewModel.division) { _, newValue in
                        if !newValue.isDouble {
                            viewModel.splitStations = false
                        }
                        settingsSync.send(division: viewModel.division, splitStations: viewModel.splitStations)
                    }
                }

                if viewModel.division.isDouble {
                    Section("Doubles Options") {
                        Toggle("Split Stations 50/50", isOn: $viewModel.splitStations)
                            .onChange(of: viewModel.splitStations) {
                                settingsSync.send(division: viewModel.division, splitStations: viewModel.splitStations)
                            }
                    }
                }

                Section("Station Weights") {
                    ForEach(hyroxStations.filter { $0.type == .workout }) { station in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(station.name)
                                    .font(.body.bold())
                                Spacer()
                                Text(station.adjustedDetail(split: viewModel.splitStations))
                                    .foregroundStyle(.secondary)
                            }
                            Text(station.info(for: viewModel.division))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
