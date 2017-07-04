class NodesPanelProvider < PanelProvider

  def price
    page = Nokogiri::HTML(RestClient.get("http://time.com"))
    page.xpath("//*").count / 100.0
  end
end
