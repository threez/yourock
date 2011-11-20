class Playlist < Sequel::Model
  many_to_many :tracks
  
  def playlist_items=(items)
    ids = items.map { |item| item["Track ID"] }
    Track.filter(:track_id => ids).each do |track|
      add_track(track)
    end
  end
end

