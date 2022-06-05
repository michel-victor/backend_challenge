require 'active_support/concern'

module DateHelpers
  extend ActiveSupport::Concern

  class_methods do
    def week_date_range(date, week, year, exception: true)
      if date
        week_date_range = date.beginning_of_week..date.end_of_week
      elsif week && year && (1..Date.new(year).last_week.cweek).include?(week) && Date.new(year).gregorian?
        beginning_of_week = Date.commercial(year, week)
        week_date_range = beginning_of_week..beginning_of_week.end_of_week
      else
        raise(I18n.t('models.merchant.errors.disburse.invalid_date_week')) if exception
      end

      if exception && week_date_range && week_date_range.first > Date.current
        raise I18n.t('models.merchant.errors.disburse.week_in_future')
      else
        week_date_range
      end
    end
  end
end