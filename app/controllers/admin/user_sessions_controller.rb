# frozen_string_literal: true

module Admin
  class UserSessionsController < ApplicationController
    skip_before_action :authenticate_admin, except: [:destroy]

    def new
      @user = User.new
    end

    def create
      @user = login(params[:username], params[:password])
      if @user.try :admin?
        redirect_back_or_to(:admin_root, notice: 'Login successful')
      elsif @user
        logout
        flash.now[:alert] = 'You are not authorized to access administration, sorry!'
        render action: 'new'
      else
        flash.now[:alert] = 'Login failed'
        render action: 'new'
      end
    end

    def destroy
      logout
      redirect_to(:admin_root, notice: 'Logged out!')
    end
  end
end
