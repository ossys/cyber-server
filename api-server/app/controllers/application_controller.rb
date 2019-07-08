class ApplicationController < ActionController::API
  include AuthHelper
  include RenderHelper

  before_action :authenticate
  respond_to :json
end
