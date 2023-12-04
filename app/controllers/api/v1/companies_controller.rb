module Api
  module V1
    class CompaniesController < ApplicationController
      # before_action :authenticate_user!
      load_and_authorize_resource
      before_action :set_company, only: %i[ show update destroy ]

      def index
        @companies = Company.all

        @serialized_companies = @companies.map { |company| serialized_company(company) }

        render json: {
          companies: @serialized_companies
        }
      end

      def show
        render json: {
          company: serialized_company(@company)
        }
      end

      def create
        @company = Company.new(company_params)
    
        if @company.save
          render json: { company: serialized_company(@company) },
          status: :created
        else
          render json: { errors: @company.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @company.update(company_params)
          render json: {
            company: serialized_company(@company)
          }
        else
          render json: { errors: @company.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        head :no_content if @company.destroy
      end

      private

      def set_company
        @company = Company.find(params[:id])
      end

      def company_params
        params.require(:company).permit(:name)
      end

      def serialized_company(company)
        CompanySerializer.new.serialize(company).to_json
      end
    end
  end
end
