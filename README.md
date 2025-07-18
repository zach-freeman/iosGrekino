## grekino

Grekino is an iOS app for discovering the Great Movies.


### Built With

* [![SwiftPM][swiftpm-img]][swiftpm-url]
* [![cloud_firestore][cloud-firestore-img]][cloud-firestore-url]
* [![firebase_auth][firebase-auth-img]][firebase-auth-url]
* [![kingfisher][kingfisher-img]][kingfisher-url]


## Getting Started

Here are some helpful tips for setting up the project locally.

### Installation

1. Get a free API Key at [TMDB](https://developer.themoviedb.org/docs/getting-started)
2. Clone the repo
```sh
git clone git@github.com:zach-freeman/iosGrekino.git
```
3. Open the project files in Xcode.
```sh
cd iosGrekino
open grekino.xcodeproj
```
4. Enter your API_KEY in `Utility/ApiKeys.swift`
```sh
static let tmdbApiKey: String = 'YOUR API KEY'
```


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[swiftpm-url]: https://www.swift.org/documentation/package-manager/
[swiftpm-img]: https://img.shields.io/badge/Swift_Package_Manager-000000?style=for-the-badge&logo=swift&logoColor=orange
[cloud-firestore-url]: https://github.com/firebase/firebase-ios-sdk
[cloud-firestore-img]: https://img.shields.io/badge/cloud_firestore-000000?style=for-the-badge&logo=swift&logoColor=orange
[firebase-auth-url]: https://github.com/firebase/firebase-ios-sdk
[firebase-auth-img]: https://img.shields.io/badge/firebase_auth-000000?style=for-the-badge&logo=swift&logoColor=orange
[kingfisher-url]: https://github.com/onevcat/Kingfisher
[kingfisher-img]: https://img.shields.io/badge/Kingisher-000000?style=for-the-badge&logo=swift&logoColor=orange
