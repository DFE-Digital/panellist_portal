class EntitiesController < ApplicationController
  def index
    @entities = client.entities
  end

  def show
    @entity = client.entity(thing: safe_params[:id], filters: safe_params[:filters].to_h)
  end

  private

  def client
    @client ||= Services::CrmClient.new
  end

  def safe_params
    params.permit(:id, filters: [:emailaddress1])
  end
end
