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
        }
        end
      }
    end
    xslt =  Nokogiri::XSLT(File.read('app/assets/stylesheets/articles.xsl'))
    @news = xslt.transform(Nokogiri::XML(builder.to_xml)).to_html
  end
end
