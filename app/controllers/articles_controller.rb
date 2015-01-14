class ArticlesController < ApplicationController
  include XmlHelper
  before_action :authenticate_user!,
    :only => [:create, :new, :edit, :update]
  def new
  end
  def edit
    style(nil, nil)
    @article = Article.find(params[:id])
    xml = Nokogiri::XML render_to_string('edit', :formats => [:xml])
    puts xml.to_xml
    xslt = get_xsl "identity"
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
    xslt = get_xsl "article"
    @data = xslt.transform(xml).to_html
    puts '===========+++++++++++++++=========' if check_if_mobile
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
  def check_if_mobile
    request.user_agent =~ /Mobile|webOS/
  end
  def get_xsl sheet
    if check_if_mobile
      Nokogiri::XSLT(File.read('app/assets/stylesheets/'+sheet+'_m.xsl'))
    else
      Nokogiri::XSLT(File.read('app/assets/stylesheets/'+sheet+'.xsl'))
    end
  end
end
