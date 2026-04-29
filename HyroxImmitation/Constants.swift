import Foundation

enum Constants {
    enum Layout {
        static let screenPadding: CGFloat = 24
        static let sectionSpacing: CGFloat = 32
        static let innerSpacing: CGFloat = 6
        static let smallSpacing: CGFloat = 8
        static let tinySpacing: CGFloat = 4
        static let buttonVerticalPadding: CGFloat = 16
        static let iconWidth: CGFloat = 24
    }

    enum FontSize {
        static let heroIcon: CGFloat = 80
        static let heroTitle: CGFloat = 60
        static let stationIcon: CGFloat = 48
        static let stationTimer: CGFloat = 64
        static let totalTimer: CGFloat = 28
    }

    enum Timer {
        static let updateInterval: TimeInterval = 0.1
    }

    enum Time {
        static let secondsPerHour = 3600
        static let secondsPerMinute = 60
    }
}
