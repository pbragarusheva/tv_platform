TV Platform Database (tv_platform)
Description
This relational database models a TV platform, including channels, shows, hosts, actors, users, broadcast schedules, ratings, statistics, watch history, and more. It is designed to manage and analyze TV content, as well as to interact with end users.

Database Structure


The database consists of several interconnected tables. The main entities are Channels, Shows, Schedule, Hosts, Actors, Users, Votes, Statistics, Watchlist, and Watch History.

The Channels table stores information about TV channels such as their name, description, logo, and type. The Shows table contains details about TV shows, including the title, description, type (e.g., series, movie, show), and associated channel. The Schedule table manages scheduled air times for shows on different channels. The Hosts table contains information about TV hosts, including their name, birth date, gender, nationality, and experience. The Actors table records information about actors, their roles in shows, and their personal details (e.g., name, gender, nationality, experience). The Users table represents users of the platform, with data such as username, email, password, and profile details. The Votes table stores ratings and comments given by users to TV shows. The Statistics table holds aggregated statistics on shows, such as average ratings and the total number of votes over a certain period. The Watchlist table represents user watchlists for TV shows, including the priority and current status (e.g., not started, in progress, completed). The Watch History table records shows that users have watched, including the date and time.

The database uses foreign keys to establish relationships between tables, such as linking shows to channels, hosts to shows, and users to their watch history and votes. Additionally, several many-to-many relationships are managed through intermediate tables, such as show_hosts, which links hosts to shows, and show_actors, which links actors to shows.

Additional Database Features


The database might include the following features: triggers for automating actions like updating statistics after a new vote is recorded, stored procedures to simplify complex queries like calculating average ratings over a period, and indexes to optimize search operations for shows by title, actors, or genre.

This structure is designed to handle large volumes of TV show data while providing efficient querying and reporting capabilities. It enables seamless interaction for both administrators managing TV content and end users interacting with the platform.
