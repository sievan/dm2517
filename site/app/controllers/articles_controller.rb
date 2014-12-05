class ArticlesController < ApplicationController
  before_action :authenticate_user!,
    :only => [:create, :new]
  def new
  end
  def edit
    @article = Article.find(params[:id])
    @data = render_to_string('edit', :formats => [:xml])
    render 'edit', :formats => [:html]
  end
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end
  def show
    @article = Article.find(params[:id])
  end
  def index
    @articles = Article.all
    xml = (Nokogiri::XML (render_to_string 'index'))
    xslt =  Nokogiri::XSLT(File.read('app/assets/stylesheets/articles.xsl'))
    xml.to_html
    render text: xslt.transform(xml).to_html
  end
  private
  def article_params
    params.require(:article).permit(:title, :text, :author)
  end
end
