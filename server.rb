require "rubygems"
require "bundler/setup"
require "sequel"
require "sinatra"
require "cgi"

configure do
  DB = Sequel.connect("sqlite://music.db")
  require File.join(File.dirname(__FILE__), "track")
  require File.join(File.dirname(__FILE__), "playlist")
end

get "/" do
  @albums = DB[:tracks].order(:album).select(:album).distinct.map(:album)
  @playlists = Playlist.all
  erb :index
end

get "/album/:name" do
  @name = params[:name]
  @tracks = Track.filter(:album => @name)
  erb :album
end

get "/playlist/:id" do
  @playlist = Playlist[params[:id]]
  @tracks = @playlist.tracks
  @name = @playlist.name
  erb :album
end

get "/media/*" do
  root = "/home/public/Music/iTunes/iTunes\ Music/"
  @path = CGI::unescape(root + params[:splat].join(""))
  @path.gsub!("file://localhost", "")
  if File.exists? @path
    send_file @path
  else
    404
  end
end