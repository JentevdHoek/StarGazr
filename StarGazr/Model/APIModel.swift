//
//  APIModel.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 27/02/2024.
//

import Foundation

import Foundation

struct AstronomyPictureOfTheDay: Codable, Identifiable {
    var id = UUID()
    var date: String
    var explanation: String
    var hdurl: String
    var media_type: String
    var service_version: String
    var title: String
    var url: String

    // Add other fields as needed

    private enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl, media_type, service_version, title, url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        date = try container.decode(String.self, forKey: .date)
        explanation = try container.decode(String.self, forKey: .explanation)
        hdurl = try container.decode(String.self, forKey: .hdurl)
        media_type = try container.decode(String.self, forKey: .media_type)
        service_version = try container.decode(String.self, forKey: .service_version)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)

        // Decode other fields as needed
    }
}
