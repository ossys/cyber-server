# frozen_string_literal: true

class ApplicationController < ActionController::API
  include AuthHelper
  include RenderHelper

  before_action :authenticate
end
