# tv_platform
Project: TV Platform Database (tv_platform)

------------Description------------
This relational database models a TV platform, including channels, shows, hosts, actors, users, broadcast schedules, ratings, statistics, watch history, and more. It is designed to manage and analyze TV content, as well as to interact with end users.

------------Database Structure------------
The database consists of several interconnected tables. The main entities are:
-> Channels: Stores information about TV channels such as their name, description, logo, and type.
-> Shows: Contains details about TV shows, including the title, description, type (e.g., series, movie, show), and associated channel.
-> Schedule: Manages scheduled air times for shows on different channels.
-> Hosts: Information about TV hosts, including their name, birth date, gender, nationality, and experience.
-> Actors: Records about actors, their roles in shows, and their personal information (e.g., name, gender, nationality, experience).
-> Users: Represents users of the platform, with data such as username, email, password, and profile details.
-> Votes: Stores ratings and comments given by users to TV shows.
-> Statistics: Aggregated statistics on shows, such as average ratings and the total number of votes over a certain period.
-> Watchlist: Represents user watchlists for TV shows, including the priority and current status (e.g., not started, in progress, completed).
-> Watch History: Records of shows that users have watched, including the date and time.

The database uses foreign keys to establish relationships between tables, such as linking shows to channels, hosts to shows, and users to their watch history and votes. Additionally, there are several many-to-many relationships managed through intermediate tables, like show_hosts, which links hosts to shows, and show_actors, which links actors to shows.

------------Additional Database Features------------
The database might include the following features:
-> Triggers: Used for automating certain actions like updating statistics after a new vote is recorded.
-> Stored Procedures: Used to simplify complex queries, such as calculating average ratings for a show over a period or updating user rankings.
-> Indexes: To optimize search operations, such as searching for shows by title, actors, or genre.

This structure is designed to handle large volumes of TV show data while providing efficient querying and reporting capabilities. It enables seamless interaction for both administrators managing TV content and end users interacting with the platform.
