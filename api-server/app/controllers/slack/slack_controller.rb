# frozen_string_literal: true

module Slack
  class SlackController < ApplicationController
    skip_before_action :authenticate

    def event
      puts "Slack event received!"
      p params

      render json: { challenge: slack_params[:challenge] }, status: 200
    end

    private

    def slack_params
      params.permit(:challenge, :token, :type)
    end
  end
end
