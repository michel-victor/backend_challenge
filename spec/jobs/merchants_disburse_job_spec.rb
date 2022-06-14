require 'rails_helper'

describe MerchantsDisburseJob, type: :job do
  describe 'run job' do
    it 'every mondays' do
      ActiveJob::Base.queue_adapter = :test
      expect { MerchantsDisburseJob.new.perform }.to have_enqueued_job.on_queue('default').at((Date.current + 1.week).beginning_of_week.midnight).exactly(:once)
    end
  end
end