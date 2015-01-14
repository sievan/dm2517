class ArticlesController < ApplicationController
  include XmlHelper
  before_action :authenticate_user!,
    :only => [:create, :new]
  def new
  end
  def edit
    style(nil, nil)
    @article = Article.find(params[:id])
    xml = Nokogiri::XML render_to_string('edit', :formats => [:xml])
    puts xml.to_xml
    xslt = Nokogiri::XSLT(File.read('app/assets/stylesheets/identity.xsl'))
    @data = xslt.transform(xml).to_html
    puts @data
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
    style(nil, nil)
    @article = Article.find(params[:id])
    xml = Nokogiri::XML render_to_string('show', :formats => [:xml])
    puts xml.to_xml
    xslt = Nokogiri::XSLT(File.read('app/assets/stylesheets/article.xsl'))
    @data = xslt.transform(xml).to_html
    puts @data
    render 'show', :formats => [:html]
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
