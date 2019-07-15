# frozen_string_literal: true

class ApplicationController < ActionController::API
  include AuthHelper

  before_action :authenticate
end
