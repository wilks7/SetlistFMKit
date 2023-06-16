

public extension SetlistFMClient {
    
    private var setlistEndpoint: String { "setlist/" }

    
    /// Returns the current version of a setlist.
    /// E.g. if you pass the id of a setlist that got edited since you last accessed it,
    /// you'll get the current version.
    /// - Parameter setlistId: The setlist id
    /// - Parameter completion: A callback that returns the requested setlist as an `FMSetlist`
    func getSetlist(setlistId: String) async throws -> FMSetlist{
        let endpoint = setlistEndpoint + setlistId
        return try await self.fetch(endpoint: endpoint)
    }
    
    /// Returns the current version of a setlist.
    /// E.g. if you pass the id of a setlist that got edited since you last accessed it,
    /// you'll get the current version.
    /// - Parameter setlistId: The setlist id
    /// - Parameter completion: A callback that returns the requested setlist as an `FMSetlist`
    func getSetlist(versionID: String) async throws -> FMSetlist{
        let endpoint = "\(setlistEndpoint)version/" + versionID
        return try await self.fetch(endpoint: endpoint)
    }
}
