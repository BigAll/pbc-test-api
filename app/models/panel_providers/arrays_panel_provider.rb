class ArraysPanelProvider < PanelProvider

  def price
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
  end
end
