import Foundation

struct LanguageCodeHelper {
    static func getCountryEmoji(from lang: String) -> String {
        switch lang {
        case "ara":
            return "🇸🇦"
        case "bre":
            return "Brezhoneg"
        case "ces":
            return "🇨🇿"
        case "cym":
            return "🏴󠁧󠁢󠁷󠁬󠁳󠁿"
        case "deu":
            return "🇩🇪"
        case "eng":
            return "🇬🇧"
        case "est":
            return "🇪🇪"
        case "fin":
            return "🇫🇮"
        case "fra":
            return "🇫🇷"
        case "hrv":
            return "🇭🇷"
        case "hun":
            return "🇭🇺"
        case "ita":
            return "🇮🇹"
        case "jpn":
            return "🇯🇵"
        case "kor":
            return "🇰🇷"
        case "nld":
            return "🇳🇱"
        case "per":
            return "🇮🇷"
        case "pol":
            return "🇵🇱"
        case "por":
            return "🇵🇹"
        case "rus":
            return "🇷🇺"
        case "slk":
            return "🇸🇰"
        case "spa":
            return "🇪🇸"
        case "srp":
            return "🇷🇸"
        case "swe":
            return "🇸🇪"
        case "tur":
            return "🇹🇷"
        case "urd":
            return "🇵🇰"
        case "zho":
            return "🇨🇳"
        default:
            return "🗺️"
        }
    }
}
