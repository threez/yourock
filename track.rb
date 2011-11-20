class Track < Sequel::Model
  many_to_many :playlists
  LOCATION = "file://localhost/Volumes/Home Directory/Music/iTunes/iTunes%20Music/"
  
  def path
    location.gsub(LOCATION, "http://10.0.1.2/iTunes%20Music/")
  end
end

