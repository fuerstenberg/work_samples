namespace :import do
  desc "Import events"
  task events: :environment do
    ________________ImportService.process
  end
end
