module JsonResponseHelper
  def json_response
    @json_response ||= JSON.parse(response.body, symbolize_names: true)
  end

  def json_request(request)
    request.to_json
  end

  def json_data(filename:)
    file_content = file_fixture(filename).read
    JSON.parse(file_content, symbolize_names: true).to_json
  end
end
