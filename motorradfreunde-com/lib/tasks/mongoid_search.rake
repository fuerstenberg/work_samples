namespace :mongoid_search do
  desc "Build mongoid search index"
  task index: :environment do
    Search.index
  end
end
