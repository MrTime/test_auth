namespace :my_sidekiq do
  desc "TODO"
  task run: :environment do

    puts "STARTED PROCESSING"

    while true
      element = $redis.rpop 'pictures_queue'
      while element.present?
        Picture.process_file(element.to_i)
        puts "RPOP #{element}"

        element = $redis.rpop 'pictures_queue'
      end

      sleep(10)
    end

    puts "STOPED PROCESSING"

  end

end
