json.errors @errors do |error|
  json.extract! error, :status, :code, :title, :detail
  if error.source_pointer.present?
    json.source do
      json.pointer error.source_pointer
    end
  end
end
