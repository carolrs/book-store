class Book
  attr_accessor :id, :title, :author_name
  def to_s 
    return "#{title} - #{author_name}"
  end
end
