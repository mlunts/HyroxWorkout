//
//  ContentView.swift
//  HyroxImmitation
//
//  Created by Marina Lunts on 29.04.26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = WorkoutViewModel()
    @State private var settingsSync = SettingsSync()

    var body: some View {
        TabView {
            WorkoutTab(viewModel: viewModel)
                .tabItem {
                    Label("Workout", systemImage: "figure.run")
                }

            SettingsView(viewModel: viewModel, settingsSync: settingsSync)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(.orange)
    }
}

private struct WorkoutTab: View {
    @Bindable var viewModel: WorkoutViewModel
    @State private var isWorkoutActive = false
    @State private var showResults = false

    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.Layout.sectionSpacing) {
                Spacer()

                VStack(spacing: Constants.Layout.innerSpacing) {
                    Text("HYROX")
                        .font(.system(size: Constants.FontSize.heroTitle, weight: .black, design: .default))
                        .foregroundStyle(.orange)

                    Text("workout tracker")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                Text(viewModel.division.rawValue)
                    .font(.callout)
                    .foregroundStyle(.secondary)

                Spacer()

                Button {
                    viewModel.start()
                    isWorkoutActive = true
                } label: {
                    Text("Start Workout")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Constants.Layout.buttonVerticalPadding)
                }
                .buttonStyle(.glass)
                .tint(.orange)
            }
            .padding(Constants.Layout.screenPadding)
            .navigationDestination(isPresented: $isWorkoutActive) {
                ActiveWorkoutView(viewModel: viewModel)
                    .onChange(of: viewModel.isFinished) { _, finished in
                        if finished {
                            isWorkoutActive = false
                            showResults = true
                        }
                    }
            }
            .navigationDestination(isPresented: $showResults) {
                ResultsView(results: viewModel.results, totalTime: viewModel.totalElapsedTime, division: viewModel.division, splitStations: viewModel.splitStations)
            }
        }
    }
}

#Preview {
    ContentView()
}
