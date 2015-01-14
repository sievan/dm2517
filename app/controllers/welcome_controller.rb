class WelcomeController < ApplicationController
  def index
    @articles = Article.all
    builder = Nokogiri::XML::Builder.new do |xml| 
      xml.articles{
        @articles.each do |article|
          xml.article{
          xml.title(article.title)
          xml.content(article.text)
          xml.author(article.author)
          xml.edit(view_context.link_to("Edit", edit_article_path(article)))
        }
        end
      }
    end
    xslt =  get_xsl "articles"
    @news = xslt.transform(Nokogiri::XML(builder.to_xml)).to_html
  end
  private
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
