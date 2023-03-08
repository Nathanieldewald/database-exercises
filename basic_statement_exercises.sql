USE albums_db;
SHOW CREATE TABLE albums;

/* 
What is the primary key for the albums table?
id
What does the column named 'name' represent?
name of the album
What do you think the sales column represents?
the amount of money made 
*/

-- Find the name of all albums by Pink Floyd.
SELECT artist, name FROM albums
WHERE artist = 'Pink Floyd';

/*
What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
1967
*/

SELECT name, release_date FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

/*
What is the genre for the album Nevermind?
Grunge, Alternative rock
*/

Select name, genre FROM albums
WHERE name = 'Nevermind';

/*
Which albums were released in the 1990s?
The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love, Dangerous,
The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica, Nevermind, and Supernatural
*/

SELECT name, release_date FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

/*
Which albums had less than 20 million certified sales?
Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, 
Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., Brothers in Arms,
Titanic: Music from the Motion Picture, Nevermind, and The Wall
*/

SELECT name, sales FROM albums
WHERE sales < 20.0;
