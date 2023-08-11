# ``SetlistFMKit``

A modern toolkit for interacting with the Setlist.fm API. Easily fetch concert setlists, tour dates, and more!

## Overview

- Fetch concert setlists with ease.
- Retrieve tour dates for your favorite artists.
- Intuitive and modern Swift API design.
- Robust search functionalities.

## Topics

### Client

- ``SetlistFMClient``
  - Your primary interface for interacting with the Setlist.fm API. Fetch setlists, artist information, venues, and more.

### Models

- ``FMArtist``
  - Represents an artist on the Setlist.fm platform. Contains details like name, genre, and associated events.
  
- ``FMSetlist``
  - Detailed information about a particular setlist, including tracks, venue, and date of performance.

- ``FMVenue``
  - Details about a concert venue, such as its location, capacity, and associated events.

- ``FMTour``
  - Represents a particular tour by an artist or a group, with details on dates, venues, and setlists.

- ``FMCity``
  - Information about a city where concerts are held, linked to venues and setlists within that city.

- ``FMTrack``
  - Represents individual tracks or songs in a setlist, with details like title, artist, and performance order.

- ``FMEvent``
  - Details about a particular live music event, potentially encompassing multiple artists and setlists.
