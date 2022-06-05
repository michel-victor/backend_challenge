class Api::V1::DisbursementsController < Api::V1::ApiController
  def index
    # Returns all disbursements that meet the conditions
    @disbursements = Disbursement.all
    filtering_params.each do |key, value|
      @disbursements = @disbursements.public_send(key, value).distinct if value.present?
    end
  end

  private

  def filtering_params
    params.slice :merchant, :week
  end
end
