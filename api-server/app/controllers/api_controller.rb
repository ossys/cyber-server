class ApiController < ApplicationController
  skip_before_action :authenticate

  def status
    json = { data: ["hello!", { time: Time.now.to_s } ] }
    render json: json, status: 200
  end
end
