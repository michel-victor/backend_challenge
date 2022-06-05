json.extract! disbursement, :id, :merchant, :date, :created_at, :updated_at
json.url api_v1_disbursements_url(disbursement, format: :json)
