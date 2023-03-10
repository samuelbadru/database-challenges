Sequence diagram for the book-store system.

```mermaid
sequenceDiagram
    participant t as terminal
    participant app as Main program (in app.rb)
    participant br as BookRepository class <br /> (in lib/book_repository.rb)
    participant db_conn as DatabaseConnection class in (in lib/database_connection.rb)
    participant db as Postgres database

    Note left of t: Flow of time <br />⬇ <br /> ⬇ <br /> ⬇ 

    t->>app: Runs `ruby app.rb`
    app->>db_conn: Opens connection to database by calling `connect` method on DatabaseConnection
    db_conn->>db_conn: Opens database connection using PG and stores the connection
    app->>br: Calls `lists_all_books` method on BookRepository
    br->>db_conn: Sends SQL query by calling `exec_params` method on DatabaseConnection
    db_conn->>db: Sends query to database via the open database connection
    db->>db_conn: Returns an array of hashes, one for each row of the books table

    db_conn->>br: Returns an array of hashes, one for each row of the books table
    loop 
        br->>br: Loops through array and creates a Book object for every row
    end
    br->>app: Returns array of Book objects
    app->>t: Prints list of books to terminal
```