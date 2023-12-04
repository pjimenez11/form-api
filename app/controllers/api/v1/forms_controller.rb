module Api
  module V1
    class FormsController < ApplicationController
      # before_action :authenticate_user!
      load_and_authorize_resource
      before_action :set_form, only: %i[ show update destroy ]

      def index
        @forms = Form.all
    
        @serialized_forms = @forms.map { |form| serialized_form(form) }
    
        render json: {
          forms: @serialized_forms
        }
      end

      def show
        render json: {
          form: serialized_form(@form)
        }
      end

      def create
        @form = Form.new(form_params)

        if @form.save
          render json: { form: serialized_form(@form) },
          status: :created
        else
          render json: {errors: @form.errors.messages }, status: :unprocessable_entity
        end
      end

      def update
        if @form.update(form_params)
          render json: {
            form: serialized_form(@form)
          }
        else
          render json: {errors: @form.errors.messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @form.destroy
          head :no_content
        else
          render json: { errors: @form.errors.messages }, status: :unprocessable_entity
        end
      end

      private

      def set_form
        @form = Form.find(params[:id])
      end

      def form_params
        params.require(:form).permit(:proyect_name, :description, :application_number,
                                     :date, :address, :justification, :status,
                                     :priority_level, :deadline, ).merge(user_id: current_user.id)
      end

      def serialized_form(form)
        FormSerializer.new.serialize(form).to_json
      end
    end
  end
end
