module DataSportsGroup
  module XmlTranslator
    def to_list(xml)
      list = []
      list_xml = xml.xpath(xml_path)
      list_xml.each{ |element| list << to_object(element.attributes) if element.name == xml_name }
      list
    end

    def to_object(attributes)
      instance = new
      attributes.each { |k,v| instance[k] = v.value }
      instance.enforce_attributes_type
      instance
    end
  end
end