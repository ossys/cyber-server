# frozen_string_literal: true

module Frontend
  require 'net/http'

  class AttacksController < FrontendApplicationController
    include RenderHelper

    def run
      attack = Attack.new(attack_params[:file_name])
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

    private

    def attack_params
      params.permit(:file_name)
    end

    def manual_attack_params
      params.permit(:node_id, :query, :output, :name)
    end
  end
end
