xml.articles{
  @articles.each do |article|
    xml.article{
    xml.title(article.title)
    xml.content(article.text)
    xml.author(article.author)
  }
  end
}