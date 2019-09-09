class Api::V1::SessionsController < ApplicationController
  def index
    @sessions = Session.all
    render json: @sessions
  end

  def create
    @session = Session.new
    @session.save
  end

  private
end
