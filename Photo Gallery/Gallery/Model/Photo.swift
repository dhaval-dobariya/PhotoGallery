//
//  Photo.swift
//  Photo Gallery
//
//  Created by Dhaval Dobariya on 11/03/22.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let id: String?
    let createdAt: String?
    let color, blurHash, photoDescription, altDescription: String?
    let urls: Urls
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case color
        case blurHash = "blur_hash"
        case photoDescription = "description"
        case altDescription = "alt_description"
        case urls, user
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb, smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - User
struct User: Codable {
    let id, username, name, firstName: String?
    let lastName: String?
    let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String?
}
