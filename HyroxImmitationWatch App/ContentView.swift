import SwiftUI

struct ContentView: View {
    @State private var viewModel = WorkoutViewModel()
    @State private var settingsSync = SettingsSync()
    @State private var isWorkoutActive = false
    @State private var showResults = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 6) {
                    Image(systemName: "figure.run")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)

                    Text("HYROX")
                        .font(.title3.bold())

                    Text(viewModel.division.shortLabel)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()
                    
                    Button {
                        viewModel.start()
                        isWorkoutActive = true
                    } label: {
                        Text("Start")
                            .frame(maxWidth: .infinity)
                    }
                    .tint(.orange)
                }
                .padding()
            }
            .navigationDestination(isPresented: $isWorkoutActive) {
                WatchActiveWorkoutView(viewModel: viewModel)
                    .onChange(of: viewModel.isFinished) { _, finished in
                        if finished {
                            isWorkoutActive = false
                            showResults = true
                        }
                    }
            }
            .navigationDestination(isPresented: $showResults) {
                WatchResultsView(
                    results: viewModel.results,
                    totalTime: viewModel.totalElapsedTime,
                    division: viewModel.division,
                    splitStations: viewModel.splitStations
                )
            }
        }
        .onChange(of: settingsSync.receivedDivision) { _, division in
            if let division {
                viewModel.division = division
            }
        }
        .onChange(of: settingsSync.receivedSplitStations) { _, split in
            if let split {
                viewModel.splitStations = split
            }
        }
    }
}

#Preview {
    ContentView()
}
