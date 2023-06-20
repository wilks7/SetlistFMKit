import XCTest
@testable import SetlistFMKit

final class SetlistFMKitTests: XCTestCase {
    var client: SetlistFMClient!
    let beatlesID = "b10bbbfc-cf9e-42e0-be17-e2c3e1d2600d"
    let phishID = FMArtist.Phish.mbid
    
    override func setUp() {
        super.setUp()
        client = .init(apiKey: "YAuLpSRz4LjQmUgE7lst6ZTkS028LwOelLS9", appName: "TestApp", orginization: "testOrg")
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

extension SetlistFMKitTests {

    
    func testSearchSetlist() async throws {
        let result = try await client.searchSetlists(artistMbid: phishID, cityName: "new york")
        let setlists = result.setlist
        for i in setlists {
            let venue = i.venue?.name ?? ""
            print(venue + i.eventDate.formatted())
        }
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
        for i in venues {
            print(i.name)
        }
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
