eui-bus
=======

Simple scraper for bus information around EUI in Florence, Italy.

This runs on my Dreamhost server with Passenger and Sinatra. It creates a mobile friendly view of bus times for buses that go by the EUI or the EUI flats, where I currently live. If the time has been updated in the last 58 minutes, it is loaded from a saved cache version rather than downloaded again from the ATAF site.
