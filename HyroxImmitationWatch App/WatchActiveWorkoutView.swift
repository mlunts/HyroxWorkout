import SwiftUI

struct WatchActiveWorkoutView: View {
    @Bindable var viewModel: WorkoutViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            VStack(spacing: 10) {
                HStack {
                    Text(viewModel.stationProgress)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(viewModel.currentStation.adjustedDetail(split: viewModel.splitStations))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 20)
                
                Text(viewModel.currentStation.name)
                    .font(.headline)
                
                Text(formatTime(viewModel.stationElapsedTime))
                    .font(.system(size: 36, weight: .bold, design: .monospaced))
                
                Text(formatTime(viewModel.totalElapsedTime))
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
            }
            .tag(0)

            buttons
                .tag(1)
        }
    }
    
    var buttons: some View {
        VStack {
            Button {
                viewModel.nextStation()
                withAnimation {
                    selectedTab = 0
                }
            } label: {
                Text(viewModel.isLastStation ? "Finish" : "Next Station")
                    .frame(maxWidth: .infinity)
            } 
            .tint(.orange)
            
            Button("Finish Early", role: .close) {
                viewModel.finishEarly()
            }
            .tint(.gray)
            
            Button("Cancel", role: .cancel) {
                viewModel.stop()
                dismiss()
            }
        }
    }
}

#Preview {
    NavigationStack {
        WatchActiveWorkoutView(viewModel: WorkoutViewModel())
    }
}
