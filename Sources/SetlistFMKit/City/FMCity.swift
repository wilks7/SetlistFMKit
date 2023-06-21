

/// The model for a City object from the Setlist.fm API
public struct FMCity: Decodable, Equatable {
    /// Unique identifier.
    public let id: String?
    
    /// The city's name, depending on the language valid values are e.g. "Müchen" or Munich
    public let name: String
    
    /**
     The code of the city's state.
     
     For most countries this is a two-digit numeric code, with which the state can be identified uniquely
     in the specific Country. The code can also be a String for other cities. Valid examples are "CA" or "02"
     which in turn get uniquely identifiable when combined with the state's country:
     
     "US.CA" for California, United States or "DE.02" for Bavaria, Germany
     
     For a complete list of available states (that aren't necessarily used in this database)
     is available in [a textfile on geonames.org](http://download.geonames.org/export/dump/admin1CodesASCII.txt).
     
     Note that this code is only unique combined with the city's Country. The code alone is **not** unique.
    */
    public let stateCode: String?
    
    /// The name of city's state, e.g. "Bavaria" or "Florida"
    public let state: String?
    
    /// The city's coordinates. Usually the coordinates of the city centre are used.
    public let coords: FMCoords
    
    /// The city's country
    public let country: FMCountry
}

/// The model for a Coords object from the Setlist.fm API
public struct FMCoords: Decodable, Equatable {
    /// The latitude part of the coordinates
    public let lat: Double
    
    /// The longitude part of the coordinates
    public let long: Double
}

extension FMCity: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(stateCode)
        hasher.combine(name)
        hasher.combine(country.code)
    }
}

/// The model for a Country object from the Setlist.fm API
public struct FMCountry: Decodable, Equatable {
    /// The country's [ISO code](http://www.iso.org/iso/english_country_names_and_code_elements). E.g. "ie" for Ireland
    public let code: String
    
    /// The country's name
    /// Can be a localized name - e.g. "Austria" or "Österreich" for Austria if the German name was requested
    public let name: String
}
