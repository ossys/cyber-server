# frozen_string_literal: true

module Frontend
  class AttackFilesController < FrontendApplicationController
    include RenderHelper

    def index
      render json: { data: AttackFile.attack_files }
    end

    def show
      contents = AttackFile.contents(attack_files_params[:file_name])
      file_name = attack_files_params[:file_name]

      data = { file_name: file_name, body: contents }
      render json: data
    end

    # TODO: add guards, proper logic, maybe db storage
    def create
      AttackFile.write(attack_files_params[:filename], attack_files_params[:body])

      render status: 201
    end

    def update
      AttackFile.write(attack_files_params[:filename], attack_files_params[:body])

      render status: 204
    end

    def destroy
      AttackFile.destroy(attack_files_params[:filename])
      render status: 204
    end

    private

    def attack_files_params
      params.permit(:file_name, :body)
    end
  end
end
