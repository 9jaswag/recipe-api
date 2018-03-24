module Response
  def json_response(object, status = :ok)
    render json: object, adapter: :json, status: status
  end
end
