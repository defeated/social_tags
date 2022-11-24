json.extract! report, :id, :url, :created_at, :updated_at
json.url report_url(report, format: :json)
