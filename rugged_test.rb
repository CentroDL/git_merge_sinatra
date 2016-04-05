# require 'sinatra'
# require 'rugged'
# require 'mime/types'
require 'pry'
configure :development do
  register Sinatra::Reloader
end


get '*' do |path|
  repo_path = ENV['HOME'] + '/code/workshop/git_merge_sinatra'
  repo = Rugged::Repository.new repo_path
  ref_name = 'refs/remotes/origin/master'
  # binding.pry
  commit = repo.ref(ref_name).target
  path.slice! 0
  path = 'index.html' if path.empty?

  entry = commit.tree.path path
  puts path
  blob = repo.lookup entry[:old]
  content = blob.content

  halt 404, "404 Not Found" unless content

  content_type MIME::Types.type_for(path).first.content_type
  content
end
