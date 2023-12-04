module Api
  module V1
    class AssignmentsController < ApplicationController
      # before_action :authenticate_user!
      load_and_authorize_resource
      before_action :set_assignment, only: %i[ show update destroy ]
    
      def index
        @assignments = current_user.assignments

        if @assignments.nil?
          render json: { errors: @assignments.errors.messages }, status: :unprocessable_entity
        else
          @serialized_assignments = @assignments.map { |assignment| serialized_assignment(assignment) }
    
          render json: {
            assignments: @serialized_assignments
          }
        end
      end
    
      def show
        if @assignment.nil?
          render json: { errors: @assignment.errors.messages }, status: :unprocessable_entity
        else
          render json: {
            assignment: serialized_assignment(@assignment)
          }
        end
      end
    
      def create
        @assignment = Assignment.new(assignment_params)
    
        if @assignment.save
          render json: {
            assignment: serialized_assignment(@assignment)
          },
          status: :created
        else
          render json: { errors: @assignment.errors.messages }, status: :unprocessable_entity
        end
      end
    
      def update
        if @assignment.update(assignment_params)
          render json: {
            assignment: serialized_assignment(@assignment)
          }
        else
          render json: { errors: @assignment.errors.messages }, status: :unprocessable_entity
        end
      end
    
      def destroy
        if @assignment.destroy
          head :no_content
        else
          render json: { errors: @assignment.errors.messages }, status: :unprocessable_entity
        end
      end
    
      private
      def set_assignment
        @assignment = current_user.assignments.find(params[:id])
      end
    
      def assignment_params
        params.require(:assignment).permit(:description, :user_id, :form_id)
      end

      def serialized_assignment(assignment)
        AssignmentSerializer.new.serialize(assignment).to_json
      end
    end
  end
end

