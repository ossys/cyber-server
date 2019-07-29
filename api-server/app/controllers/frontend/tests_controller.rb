# frozen_string_literal: true

module Frontend
  require 'gauntlt'

  class TestsController < FrontendApplicationController
    include RenderHelper

    before_action :set_attack_path

    ATTACKS_DIR = File
      .expand_path('../../../../attacks', __FILE__)
      .freeze

    TMP_DIR = File
      .expand_path('../../../../tmp', __FILE__)
      .freeze

    def run
      out_file = File.join(
        TMP_DIR,
        "#{tests_params[:attack_name]}-#{Time.now}.json")
      attack = Gauntlt::Attack.new(@attack_path, [], "json", out_file)

      begin
        b = attack.run
      rescue SystemExit
      rescue Exception => e
        puts "exception: #{e}"
      end

      p b

      result = File.read(out_file)
      #File.delete(out_file)
      test = Test.new(attack_name: tests_params[:attack_name], result: result)
      if test.valid? && test.save
        render json: { data: {attack_name: test.attack_name, result: test.result }}, status: 201
      else
        render json: { errors: test.errors }, status: 400
      end
    end


    private

    def tests_params
      params.permit(:attack_name)
    end

    def set_attack_path
      @attack_path = File.join(ATTACKS_DIR, params[:attack_name])
    end
  end
end
