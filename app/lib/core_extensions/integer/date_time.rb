module CoreExtensions
  module Integer
    module DateTime
      def to_datetime
        Time.at(self).utc.to_datetime
      end
    end
  end
end

Integer.include CoreExtensions::Integer::DateTime
