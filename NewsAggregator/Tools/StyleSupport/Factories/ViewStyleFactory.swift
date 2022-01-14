import Foundation

enum ViewStyleFactory {
    enum View {
        static let commonSceneBackground = ViewStyle(backgroundColor: Asset.commonBackgroundColor.color)
    }
    
    enum Control {
        static let roundedControl = ViewStyle(backgroundColor: Asset.commonBackgroundColor.color, shadowStyle: ShadowStyleFactory.roundedControl)
        static let main = ViewStyle(
            backgroundColor: Asset.mainButtonBackgroundColor.color,
            cornerRadius: 10,
            textStyle: TextStyleFactory.Button.main
        )
    }
}
