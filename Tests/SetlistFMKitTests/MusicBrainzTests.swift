import XCTest
@testable import SetlistFMKit

final class MusicBrainzTests: XCTestCase {

    // Insert your actual MusicBrainz API key here
    var client: MusicBrainzClient!
    struct Artist {
        let name: String
        let id: String
    }
    let beatles = Artist(name: "The Beatles", id: "b10bbbfc-cf9e-42e0-be17-e2c3e1d2600d")
    let phish = Artist(name: "Phish", id: "e01646f2-2a04-450d-8bf2-0d993082e058")

    override func setUp() {
        super.setUp()
        let appName = "YourAppName"
        client = MusicBrainzClient(appName: appName, version: "1.0", contact: "dev@\(appName).app")
    }

    override func tearDown() {
        client = nil
        super.tearDown()
    }

    func testGetArtist() async throws {
        let id = phish.id
        do {
            let artist = try await client.getArtist(mbid: id) // Insert a valid MBID
            XCTAssertEqual(artist.id, id)
            XCTAssertNotNil(artist.lifeSpan?.begin, "Artist data should not be nil")

        } catch {
            XCTFail("Failed to fetch artist: \(error)")
        }
    }

    func testSearchArtist() async throws {
        let artist = phish
        do {
            let artists = try await client.searchArtist(artist: artist.name) // Search a valid artist name
            XCTAssertFalse(artists.isEmpty, "Artists array should not be empty")
            XCTAssertTrue(artists.contains(where: {$0.name == artist.name}), "Artists should containt \(artist.name)")

        } catch {
            XCTFail("Failed to fetch artists: \(error)")
        }
    }
}
