class Location < ActiveRecord::Base
  def self.update_location_by_address
    find_each(:start => 0) do |l|
      points = Engine::Interaction::NaverApi.location_data_by_address l.address
      l.update_attributes(points)
    end
  end

  def address
    [si, gu, dong].join(' ')
  end

  def address_sigu
    [si, gu].join(' ')
  end
end
