# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :text
#  content    :text
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticlesController < ApplicationController
  before_action :authenticate_user!, :protect_from_forgery, :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    begin
      @articles = Article.paginate(:page => params[:page], :per_page => params[:per_page] ||= 30).order(created_at: :desc)
    rescue
      redirect_to articles_index_path, notice: 'Article was not found.'
    end

  end

  # GET /articles/1
  # GET /articles/1.json
  def show

  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy

    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    begin

      # Throws exception if not found
      @article = Article.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      redirect_to action: :index
      flash[:alert] = "The requested article was not found!"
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :content, :category, :user_id)
    # Students, make sure to add the user_id parameter as a symbol here ^^^^^^
  end
end