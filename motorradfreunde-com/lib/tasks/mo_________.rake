namespace :import do
  namespace :mot________________ do
    desc "Import ___________________.de dealers"
    task :dealers => :environment do
      Importer::Motorradonline::Dealer.import
    end
  end
end
