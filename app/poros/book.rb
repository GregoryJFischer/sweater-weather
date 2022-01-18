class Book
  attr_reader :isbn, :title, :publisher

  def initialize(info)
    @isbn = info[:isbn]
    @title = info[:title]
    @publisher = info[:publisher]
  end
end