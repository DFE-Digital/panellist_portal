class EntitiesController < ApplicationController
  def index
    @entities = client.entities
  end

  def show
    @entity = client.entity(params[:id])
  end

  private

  def client
    @client ||= Services::CrmClient.new
  end
end
