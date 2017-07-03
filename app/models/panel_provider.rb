class PanelProvider < ActiveRecord::Base

  def price
    case code
      when "letters"
        page = Nokogiri::HTML(RestClient.get("http://time.com"))
        page.search('script').each {|el| el.unlink}
        page.search('style').each {|el| el.unlink}
        content = page.text.gsub(/\s+/, " ").strip
        content.count('a') / 100.0
      when "arrays"
        parser = YAJI::Parser.new(RestClient.get("http://openlibrary.org/search.json?q=the+lord+of+the+rings"))
        counter = 0
        parser.each("/docs/") do |obj|
          obj.each_value do |value|
            if value.instance_of?(Array) && value.size > 10
              counter += 1
            end
          end
        end
        counter
      when "nodes"
        page = Nokogiri::HTML(RestClient.get("http://time.com"))
        page.xpath("//*").count / 100.0
    end
  end
end
