# frozen_string_literal: true
module Api
  module V1
    class ContactsController < ApplicationController
      skip_before_action :authenticate_request

      def index
        render json: { contacts: all_contacts(params["user_id"]) }, status: :ok
      end

      def create
        @contact = Contact.create(contact_params)
        if @contact.save
          response = { contacts: all_contacts(contact_params["user_id"]), message: 'Contact created successfully!'}
          render json: response, status: :created
        else
          render json: @contact.errors, status: :bad
        end
      end

      def update
        contact = Contact.find(params[:id])
        if contact.update_attributes(contact_params)
          render json: contact.to_json, status: :ok
        else
          render json: { errors: contact.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        contact = Contact.find(params[:id])
        if contact.destroy
          render json: contact.to_json, status: :ok
        else
          render json: { errors: contact.errors }, status: :unprocessable_entity
        end
      end

      private
      def contact_params
        params.permit(
            :id,
            :user_id,
            :group_id,
            :name,
            :email
        )
      end

      def all_contacts user_id
        user = User.find(user_id)
        user.contacts.group('group_id', 'contacts.id', 'groups.name').order(:name).
            select('id', 'contacts.name as contact_name', 'email', 'group_id', 'groups.name as group_name').group_by(&:group_name)
      end
    end
  end
end
