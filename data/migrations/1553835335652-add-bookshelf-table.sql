March 28/2019
Migration Notes

Query 1: Create bookshelves table.
CREATE TABLE BOOKSHELVES (id SERIAL PRIMARY KEY, name VARCHAR(255));

This query creates a second table in the lab14_normal database named bookshelves. 

You can confirm the success of this command by typing \d bookshelves in your SQL shell. You should see the bookshelves table schema.

------
Query 2: INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;

This query will use a subquery to retrieve unique bookshelf values from the books table and insert each one into the bookshelves table in the name column. 

You can confirm the success of this command by typing SELECT COUNT(*) FROM bookshelves; in your SQL shell. The number should be greater than zero.

-----
Query 3: ALTER TABLE books ADD COLUMN bookshelf_id INT;

This query will add a column to the books table named bookshelf_id. This will connect each book to a specific bookshelf in the other table.

Confirm the success of this command by typing \d books in your SQL shell. The table schema should now include a column for bookshelf_id, in addition to the column for the string bookshelf; the bookshelf column will be removed in Query 5.

-----
Query 4: UPDATE books SET bookshelf_id=shelf.id FROM (SELECT * FROM bookshelves) AS shelf WHERE books.bookshelf = shelf.name;

This query will prepare a connection between the two tables. It works by running a subquery for every row in the books table. The subquery finds the bookshelf row that has a name matching the current book's bookshelf value. The id of that bookshelf row is then set as the value of the bookshelf_id property in the current book row.

You can confirm the success of this command by typing SELECT bookshelf_id FROM books; in your SQL shell. The result should display a column containing the unique ids for the bookshelves. The numbers should match the total number returned from Query 2 when you confirmed the success of the insertion of names into the bookshelves table.

-----
Query 5: ALTER TABLE books DROP COLUMN bookshelf;

This query will modify the books table by removing the column named bookshelf. Now that the books table contains a bookshelf_id column which will become a foreign key, your table does not need to contain a string representing each bookshelf.

You can confirm the success of this command by typing \d books in your SQL shell. The books table schema should be updated to reflect the schema provided above, without the bookshelf column.

-----
Query 6: ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);

This query will modify the data type of the bookshelf_id in the books table, setting it as a foreign key which references the primary key in the bookshelves table. Now PostgreSQL knows HOW these 2 tables are connected.

Confirm the success of this command by typing /d books in your SQL shell. You should see details about the foreign key constraints, as shown in the schema above.

