import Foundation

struct User: Decodable {
    let login: String

    let id: Int
    let avatarURL: String

    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
    }
}
