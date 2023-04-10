class BooksController < ApplicationController
  before_action :correct_book,only: [:edit]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @book_comment = BookComment.new
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
  end

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    books = Book.includes(:favorited_users)
    if params[:latest]
      @books = Book.latest.page(params[:page]).per(5)
    elsif params[:old]
      @books = Book.old.page(params[:page]).per(5)
    elsif params[:star_count]
      @books = Book.star_count.page(params[:page]).per(5)
    else
      books = books.sort_by {|x| x.favorited_users.includes(:favorites).where(created_at: from...to).size }.reverse
      @books = Kaminari.paginate_array(books).page(params[:page]).per(5)
    end
    @book = Book.new
    @user = @book.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate, :tag)
  end

  def correct_book
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
