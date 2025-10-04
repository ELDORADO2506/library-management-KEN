-- Create tables for KEN Library

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS books (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  author TEXT,
  genre TEXT,
  isbn TEXT,
  publisher TEXT,
  year INTEGER,
  default_location TEXT
);

CREATE TABLE IF NOT EXISTS locations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS copies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  book_id INTEGER NOT NULL,
  accession_no TEXT UNIQUE,
  current_location TEXT,
  status TEXT DEFAULT 'available',           -- available | issued | lost
  FOREIGN KEY (book_id) REFERENCES books(id)
);

CREATE TABLE IF NOT EXISTS members (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT
);

CREATE TABLE IF NOT EXISTS loans (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  copy_id INTEGER NOT NULL,
  member_id INTEGER NOT NULL,
  issue_date TEXT NOT NULL,
  due_date TEXT,
  return_date TEXT,
  status TEXT DEFAULT 'issued',              -- issued | returned | overdue
  FOREIGN KEY (copy_id) REFERENCES copies(id),
  FOREIGN KEY (member_id) REFERENCES members(id)
);

-- Helpful indexes
CREATE INDEX IF NOT EXISTS idx_books_title ON books(title);
CREATE INDEX IF NOT EXISTS idx_books_genre ON books(genre);
CREATE INDEX IF NOT EXISTS idx_copies_book ON copies(book_id);
CREATE INDEX IF NOT EXISTS idx_loans_copy ON loans(copy_id);
CREATE INDEX IF NOT EXISTS idx_loans_member ON loans(member_id);
