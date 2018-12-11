# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      skip_before_action :authenticate_request

      def index
        render json: { groups: get_groups(params["user_id"]) }, status: :ok
      end

      def create
        @group = Group.create(group_params)
        if @group.save
          response = { groups: get_groups(group_params["user_id"]), message: 'Group created successfully!'}
          render json: response, status: :created
        else
          render json: @group.errors, status: :bad
        end
      end

      def update
        group = Group.find(params[:id])
        if group.update_attributes(group_params)
          render json: group.to_json, status: :ok
        else
          render json: { errors: group.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        group = Group.find(params[:id])
        if group.destroy
          render json: group.to_json, status: :ok
        else
          render json: { errors: group.errors }, status: :unprocessable_entity
        end
      end

      private

      def group_params
        params.permit(
            :id,
            :user_id,
            :name,
            :active
        )
      end

      def get_groups user_id
        Group.where(user_id: user_id).order(:name)
      end
    end
  end
end
