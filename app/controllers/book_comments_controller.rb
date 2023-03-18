class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
    @book_comment = BookComment.new
    # redirect_to book_path(@book)
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.find(params[:id])
    @book_comment.destroy
    # redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment, :book_id, :user_id)
  end
end
