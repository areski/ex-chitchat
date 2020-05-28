--
-- chit_chat_dev=# SELECT * FROM rooms;
--  id |  name   | description | user_id |     inserted_at     |     updated_at
-- ----+---------+-------------+---------+---------------------+---------------------
--

INSERT INTO rooms (
    name, description, user_id, inserted_at, updated_at
)
SELECT
    left(md5(i::text), 20),
    '',
    1,
    NOW(),
    NOW()
FROM generate_series(1, 1000000) s(i);

--
--
-- chit_chat_dev=# SELECT * FROM users;
--  id |     name      | username |     inserted_at     |     updated_at
-- ----+---------------+----------+---------------------+---------------------
--   1 | Areski Belaid | areski   | 2020-05-18 11:07:15 | 2020-05-18 16:53:31
--

INSERT INTO users (
    name, username, inserted_at, updated_at
)
SELECT
    left(md5(i::text), 10),
    left(md5(i::text), 10),
    NOW(),
    NOW()
FROM generate_series(1, 100) s(i);