import XCTest
@testable import SetlistFMKit

final class SetlistFMTests: XCTestCase {
    var client: SetlistFMClient!
    let beatlesID = "b10bbbfc-cf9e-42e0-be17-e2c3e1d2600d"
    let phishID = "e01646f2-2a04-450d-8bf2-0d993082e058"
    
    override func setUp() {
        super.setUp()
        client = .init(apiKey: "YAuLpSRz4LjQmUgE7lst6ZTkS028LwOelLS9")
    }
    
    override func tearDown() {
        client = nil
        super.tearDown()
    }
    
    
    /// Fetches an Artist from the SetlistFM API and checks its validity.
    func testArtist() async throws {
        do {
            let artist = try await client.getArtist(mbid: phishID)
            XCTAssertEqual(artist.mbid, phishID, "Artist data contains the correct id")
        } catch {
            XCTFail("Failed to fetch artist: \(error)")
        }
    }
    
    /// Fetches an Artist's Setlist from the SetlistFM API and checks its validity.
    func testSetlist() async throws  {
        let result = try await client.getArtistSetlists(mbid: phishID, pageNumber: 1)
        let setlists = result.setlist
        XCTAssertEqual(result.itemsPerPage, setlists.count)
        
        guard let first = setlists.first else {return}
        let setlist = try await client.getSetlist(setlistId: first.id)
        XCTAssertEqual(setlist.id, first.id, "Setlist data contains the correct id")
    }
}

extension SetlistFMTests {

    
    func testSearchSetlist() async throws {
        let result = try await client.searchSetlists(cityName: "new york")
        let setlists = result.setlist
        if result.total < result.itemsPerPage {
            XCTAssertEqual(result.total, setlists.count)
        } else {
            XCTAssertEqual(result.itemsPerPage, setlists.count)
        }
    }
    
    func testSearchArtist() async throws {
        let result = try await client.searchArtists(name: "beatles")
        let artists = result.artist
        if result.total < result.itemsPerPage {
            XCTAssertEqual(result.total, artists.count)
        } else {
            XCTAssertEqual(result.itemsPerPage, artists.count)
        }
    }
    
    func testSearchVenue() async throws {
        let result = try await client.searchVenues(name: "madison square garden")
        let venues = result.venue
        if result.total < result.itemsPerPage {
            XCTAssertEqual(result.total, venues.count)
        } else {
            XCTAssertEqual(result.itemsPerPage, venues.count)
        }
    }
    
    func testSearchCity() async throws {
        let result = try await client.searchCities(name: "new york")
        let cities = result.cities
        if result.total < result.itemsPerPage {
            XCTAssertEqual(result.total, cities.count)
        } else {
            XCTAssertEqual(result.itemsPerPage, cities.count)
        }
    }
    
    func testSearchCountry() async throws {
        let result = try await client.searchCountries()
        let countries = result.country
        if result.total < result.itemsPerPage {
            XCTAssertEqual(result.total, countries.count)
        } else {
            XCTAssertEqual(result.itemsPerPage, countries.count)
        }
    }

}
