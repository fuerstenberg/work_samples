namespace :my_paperclip do

  task :backup => :environment do
    src  = File.join(Rails.root.to_s, "public")
    dest = File.join(Rails.root.to_s, "public/system/photos_backup")

    FileUtils.mkdir_p dest

    Photo.find_each do |photo|
      # [Photo.first].each do |photo|
      extension = case photo.photo_content_type
      when "image/gif"
        "gif"
      when "image/jpeg"
        "jpg"
      when "image/jpg"
        "jpg"
      when "image/pjpeg"
        "jpg"
      when "image/png"
        "png"
      end
      src_file  = File.join(src, photo.url.split("?")[0])
      dest_file = File.join(dest, photo.id.to_s, "original.#{extension}")

      FileUtils.mkdir_p File.join(dest, photo.id.to_s)
      unless File.exists?(dest_file)
        begin
          FileUtils.cp src_file, dest_file
        rescue => e
          puts "#{src_file}   --->>>   #{dest_file}"
          puts "^^^^ ERROR "
        end
      end
    end
  end

end
