namespace :status do
  
  desc "approved => publish"
  task :publish => :environment do
    Post.where(life_cycle:"approved").each {|post| post.published}
  end

  desc "published => archiv"
  task :archiv => :environment do
    Post.where(life_cycle:"approved").each do |post|
      time_now = Time.now.to_i
      time_update = post.updated_at.to_time.to_i
      post.go_to_archive if ((time_now - time_update)/ 86400 ) >= 3
    end
  end
end