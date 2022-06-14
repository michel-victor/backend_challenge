namespace :jobs do
  desc 'Run ActiveJob tasks'
  task run: :environment do
    begin
      # Prevent not repeat jobs and update all of them
      not_repeating_job = %w[MerchantsDisburseJob]
      # Check all jobs on all queues
      Sidekiq::Queue.all.each do |queue|
        Rails.logger.info "[JobTask.run] Cleaning up #{queue.size} entries from queue '#{queue.name}'"
        queue.each do |job|
          job.delete if not_repeating_job.include?(job.args.first['job_class'])
        end
      end
      # Check just scheduled jobs
      Sidekiq::ScheduledSet.new.each do |job|
        job.delete if not_repeating_job.include?(job.args.first['job_class'])
      end
      # Launch again periodic jobs
      not_repeating_job.each { |job| job.constantize.perform_later }
    rescue => error
      puts error.inspect
    else
      puts '*** Jobs started successfully. ***'
    end
  end
end
