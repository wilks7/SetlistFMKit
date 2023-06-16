import XCTest
@testable import SetlistFMKit

final class MusicBrainzTests: XCTestCase {

    // Insert your actual MusicBrainz API key here
    var client: MusicBrainzClient!
    let beatlesID = "b10bbbfc-cf9e-42e0-be17-e2c3e1d2600d"
    let phishID = "e01646f2-2a04-450d-8bf2-0d993082e058"

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
        do {
            let artist = try await client.getArtist(mbid: phishID) // Insert a valid MBID
            XCTAssertNotNil(artist, "Artist data should not be nil")
        } catch {
            XCTFail("Failed to fetch artist: \(error)")
        }
    }

    func testSearchArtist() async throws {
        do {
            let artists = try await client.searchArtist(artist: "Phish") // Search a valid artist name
            XCTAssertFalse(artists.isEmpty, "Artists array should not be empty")
            XCTAssertTrue(artists.contains(where: {$0.name == "Phish"}), "Artists array should not be empty")

        } catch {
            XCTFail("Failed to fetch artists: \(error)")
        }
    }
}
