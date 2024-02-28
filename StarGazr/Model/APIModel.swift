//
//  APIModel.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 27/02/2024.
//

import Foundation

import Foundation

struct APODModel: Codable {
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String
}

//voorbeeld response
//{
//    "copyright": "\nDario Giannobile\n",
//    "date": "2024-02-28",
//    "explanation": "How does the sky turn dark at night? In stages, and with different characteristic colors rising from the horizon. The featured image shows, left to right, increasingly late twilight times after sunset in 20 different vertical bands. The picture was taken last month in Syracuse, Sicily, Italy, in the direction opposite the Sun. On the far left is the pre-sunset upper sky.  Toward the right, prominent bands include the Belt of Venus, the Blue Band, the Horizon Band, and the Red Band. As the dark shadow of the Earth rises, the colors in these bands are caused by direct sunlight reflecting from air and aerosols in the Earth's atmosphere, multiple reflections sometimes involving a reddened sunset, and refraction. In practice, these bands can be diffuse and hard to discern, and their colors can depend on colors near the setting Sun. Finally, the Sun completely sets and the sky becomes dark. Don't despair -- the whole thing will happen in reverse when the Sun rises again in the morning.",
//    "hdurl": "https://apod.nasa.gov/apod/image/2402/TwilightShades_Giannobile_1600.jpg",
//    "media_type": "image",
//    "service_version": "v1",
//    "title": "Shades of Night",
//    "url": "https://apod.nasa.gov/apod/image/2402/TwilightShades_Giannobile_1080.jpg"
//}
