module DataSportsGroup
  module StringConverter
    def string_to_date(prop)
      self[prop] = Date.parse(self[prop]) if self[prop].class == String
    end

    def string_to_datetime(prop, str=nil)
      str ||= self[prop]
      self[prop] = DateTime.parse(str) if self[prop].class == String
    end

    def string_to_integer(prop)
      str = self[prop]

      if str.class == String
        self[prop] = str.strip.empty? ? 0 : str.to_i
      end
    end
  end
end
