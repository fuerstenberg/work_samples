namespace :import do
  desc "Import feeds"
  task feeds: :environment do
    FeedImportService.import
  end
end
