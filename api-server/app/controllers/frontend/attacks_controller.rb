# frozen_string_literal: true

module FrontendApi
  require 'net/http'

  class AttacksController < FrontendApplicationController
    include RenderHelper

    ATTACKS_DIR = File
      .expand_path('../../../../attacks', __FILE__)
      .freeze

    before_action :set_file_path, except: [:index, :webhook]

    def index
      data = Dir
        .entries(ATTACKS_DIR)
        .select{|e| !File.directory?(e) }

      render json: { data: data }
    end

    def show
      contents = File.read(@file_path + '.attack')
      data = { file_name: params[:file_name], body: contents }

      render json: data
      rescue
      render status: 404
    end

    # TODO: add guards, proper logic, maybe db storage
    def create
      File.write(@file_path, attacks_params[:body])

      render status: 201
    end

    # TODO: add guards, proper logic, maybe db storage
    def update
      File.write(@file_path, attacks_params[:body])

      render status: 204
    end

    def destroy
      File.delete(@file_path) if File.exist?(@file_path)
      render status: 204
    end

    #def webhook
      #uri = URI.parse(ENV['SLACK_WEBHOOK'])

      #data = {text: 'hello, world'}.to_json

      #request = Net::HTTP::Post.new(uri.request_uri)
      #request['Content-Type'] = 'application/json'
      #request.body = data.to_s

      #http = Net::HTTP.new(uri.host, uri.port)
      #http.use_ssl = (uri.scheme == 'https')

      #http.request(request)
    #end

    private

    def attacks_params
      params.permit(:file_name, :body)
    end

    def set_file_path
      @file_path = File.join(ATTACKS_DIR, params[:file_name])
    end
  end
end
