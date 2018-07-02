json.data do
  json.id @terms_of_service.id
  json.type 'terms_of_service'
  json.attributes do
    json.extract! @terms_of_service, :content, :version
    json.effective_at @terms_of_service.effective_at.to_i
  end
end
