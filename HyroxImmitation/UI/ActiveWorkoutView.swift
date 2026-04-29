import SwiftUI

struct ActiveWorkoutView: View {
    @Bindable var viewModel: WorkoutViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: Constants.Layout.sectionSpacing) {
            Text(viewModel.stationProgress)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            VStack(spacing: Constants.Layout.smallSpacing) {
                Text(viewModel.currentStation.name)
                    .font(.largeTitle.bold())

                Text(viewModel.currentStation.adjustedDetail(split: viewModel.splitStations))
                    .font(.title2)
                    .foregroundStyle(.secondary)

                Text(viewModel.currentStation.info(for: viewModel.division))
                    .font(.subheadline)
                    .foregroundStyle(.tertiary)
                    .multilineTextAlignment(.center)
            }

            Spacer()
            VStack(spacing: Constants.Layout.tinySpacing) {
                Text("Station Time")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(formatTime(viewModel.stationElapsedTime))
                    .font(.system(size: Constants.FontSize.stationTimer, weight: .bold, design: .monospaced))
                    .foregroundStyle(.orange)
            }
            Spacer()

            VStack(spacing: Constants.Layout.tinySpacing) {
                Text("Total Time")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(formatTime(viewModel.totalElapsedTime))
                    .font(.system(size: Constants.FontSize.totalTimer, weight: .medium, design: .monospaced))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                viewModel.nextStation()
            } label: {
                Text(viewModel.isLastStation ? "Finish" : "Next Station")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Constants.Layout.buttonVerticalPadding)
            }
            .buttonStyle(.glass)
            .tint(.orange)
        }
        .padding(Constants.Layout.screenPadding)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    viewModel.stop()
                    dismiss()
                }
                .foregroundStyle(.secondary)
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Finish") {
                    viewModel.finishEarly()
                }
                .foregroundStyle(.secondary)
                .bold()
            }
        }
    }
}
#Preview {
    NavigationStack {
        ActiveWorkoutView(viewModel: WorkoutViewModel())
    }
}

