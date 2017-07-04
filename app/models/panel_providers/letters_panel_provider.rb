class LettersPanelProvider < PanelProvider

  def price
    page = Nokogiri::HTML(RestClient.get("http://time.com"))
    page.search('script').each {|el| el.unlink}
    page.search('style').each {|el| el.unlink}
    content = page.text.gsub(/\s+/, " ").strip
    content.count('a') / 100.0
  end

end
