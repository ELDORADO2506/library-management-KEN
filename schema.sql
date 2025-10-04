-- Drop old tables if they exist (so we start clean)
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS copies;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS locations;

-- Locations (45 compartments)
CREATE TABLE locations (
  id           INTEGER PRIMARY KEY AUTOINCREMENT,
  location_id  TEXT UNIQUE NOT NULL,
  name         TEXT NOT NULL,
  description  TEXT DEFAULT ''
);

-- Members
CREATE TABLE members (
  id           INTEGER PRIMARY KEY AUTOINCREMENT,
  member_id    TEXT UNIQUE NOT NULL,
  name         TEXT NOT NULL,
  phone        TEXT,
  email        TEXT
);

-- Books (one row per title)
CREATE TABLE books (
  id             INTEGER PRIMARY KEY AUTOINCREMENT,
  title          TEXT NOT NULL,
  author         TEXT,
  publisher      TEXT,
  genre          TEXT,
  default_location TEXT  -- e.g. "Compartment 1"
);

-- Copies (physical copies of a book)
CREATE TABLE copies (
  id                INTEGER PRIMARY KEY AUTOINCREMENT,
  book_id           INTEGER NOT NULL,
  accession_no      TEXT,           -- optional label/number
  current_location  TEXT,           -- matches locations.location_id (e.g. "Compartment 1")
  status            TEXT DEFAULT 'available', -- 'available' or 'issued'
  FOREIGN KEY(book_id) REFERENCES books(id)
);

-- Issue/Return transactions
CREATE TABLE transactions (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  copy_id       INTEGER NOT NULL,
  member_id     INTEGER NOT NULL,
  issue_date    TEXT NOT NULL,
  return_date   TEXT,             -- NULL when still out
  notes         TEXT,
  FOREIGN KEY(copy_id) REFERENCES copies(id),
  FOREIGN KEY(member_id) REFERENCES members(id)
);
