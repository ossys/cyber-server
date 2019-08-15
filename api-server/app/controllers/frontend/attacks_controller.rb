# frozen_string_literal: true

module Frontend
  require 'net/http'

  class AttacksController < FrontendApplicationController
    include RenderHelper

    def index
      render json: { data: Attack.attack_files }
    end

    def show
      contents = File.read(Attack.file_path(attacks_params[:file_name]))
      data = { file_name: params[:file_name], body: contents }

      render json: data
    end

    # TODO: add guards, proper logic, maybe db storage
    def create
      File.write(Attack.file_path(attacks_params[:file_name]))

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

    def run
      attack = Attack.new(attacks_params[:file_name])
      result = attack.run!

      render json: { data: result }, status: 200
    end

    def manual_run
      p 'creating'
      AttackFile.create(manual_attack_params)

      p 'initializing attack'
      attack = Attack.new("#{manual_attack_params[:name]}.attack")
      p 'running attack'
      result = attack.run!

      p 'rendering data'
      render json: { data: result }, status: 200
    end

    # def webhook
    # uri = URI.parse(ENV['SLACK_WEBHOOK'])

    # data = {text: 'hello, world'}.to_json

    # request = Net::HTTP::Post.new(uri.request_uri)
    # request['Content-Type'] = 'application/json'
    # request.body = data.to_s

    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = (uri.scheme == 'https')

    # http.request(request)
    # end

    private

    def attacks_params
      params.permit(:file_name, :body)
    end

    def manual_attack_params
      params.permit(:node_id, :query, :output, :name)
    end
  end
end
