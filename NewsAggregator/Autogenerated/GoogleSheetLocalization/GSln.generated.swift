// GoogleSheet: https://docs.google.com/spreadsheets/d/1HpckF6iXbEOCkUF-hMXFbVcYrJLVjIgHko2wGGQLfMs/edit#gid=0
// Generated using GoogleSheetLocalizationExport: https://github.com/muzle/GoogleSheetLocalizationExport

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum GSln {
	internal enum PostsScene {
		/// Новости
		internal static let navigationTitle = GSln.tr("Localizable", "PostsScene.navigationTitle")
	}
	internal enum InvalidPostUrlAlert {
		/// Ошибка
		internal static let title = GSln.tr("Localizable", "InvalidPostUrlAlert.title")
		/// Не правильный URL
		internal static let message = GSln.tr("Localizable", "InvalidPostUrlAlert.message")
		/// Хоршо
		internal static let ok = GSln.tr("Localizable", "InvalidPostUrlAlert.ok")
	}
	internal enum ShortPostInfo {
		/// Перейти
		internal static let completeButtonTitle = GSln.tr("Localizable", "ShortPostInfo.completeButtonTitle")
	}
	internal enum TabBarTitle {
		/// Новости
		internal static let posts = GSln.tr("Localizable", "TabBarTitle.posts")
		/// Настройки
		internal static let settings = GSln.tr("Localizable", "TabBarTitle.settings")
	}
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension GSln {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
