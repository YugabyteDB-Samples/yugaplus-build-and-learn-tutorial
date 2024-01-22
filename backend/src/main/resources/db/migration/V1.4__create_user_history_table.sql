DROP TABLE IF EXISTS user_history;

CREATE TABLE user_history(
    user_id uuid NOT NULL,
    movie_id integer NOT NULL,
    start_watch_time int NOT NULL DEFAULT 0,
    added_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_account(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id),
    PRIMARY KEY (user_id, movie_id)
);

-- Generate sample data for user with email "user@gmail.com"
-- Add three movies from the movie table
WITH user_data AS (
    SELECT
        id
    FROM
        user_account
    WHERE
        email = 'user1@gmail.com')
INSERT INTO user_history(user_id, movie_id, start_watch_time, added_time)
SELECT
    (
        SELECT
            id
        FROM
            user_data),
    id,
    0,
    CURRENT_TIMESTAMP
FROM
    movie
WHERE
    id IN (
        SELECT
            id
        FROM
            movie
        ORDER BY
            RANDOM()
        LIMIT 3);

