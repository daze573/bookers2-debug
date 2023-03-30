class TagSearchesController < ApplicationController
  def tag_search
    @model = Book
    @word = params[:word]
    @books = Book.where("tag LIKE?","%#{@word}%")
    render "tag_searches/show"
  end
end
