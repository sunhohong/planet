namespace :planet do
  namespace :location do
    desc "Update location data from Naver API"
    task :update_from_naver => :environment do
      Location.update_location_by_address
    end
  end
end