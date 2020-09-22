require "pg"

class Bookmarks
  DEFAULT_BOOKMARKS = ["https://www.bbc.com", "https://www.google.com", "https://www.cats.com", "https://www.reddit.com"]

  def initialize(array_of_bookmarks = DEFAULT_BOOKMARKS)
    @stored_bookmarks = array_of_bookmarks
  end

  def self.all
    if ENV["ENVIRONMENT"] == "test"
      connection = PG.connect(dbname: "bookmark_manager_test")
    else
      connection = PG.connect(dbname: "bookmark_manager")
    end

    result = connection.exec("SELECT * FROM bookmarks;")
    result.map { |bookmark| bookmark["url"] }
  end

  def self.add(bookmark_url)
    if ENV["ENVIRONMENT"] == "test"
      connection = PG.connect(dbname: "bookmark_manager_test")
    else
      connection = PG.connect(dbname: "bookmark_manager")
    end

    connection.exec("INSERT INTO bookmarks (url) VALUES ('#{bookmark_url}');")
  end
end
