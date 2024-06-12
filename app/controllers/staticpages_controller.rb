class StaticpagesController < ApplicationController
  skip_before_action :authenticate_user!
  include ContentHelper

  def top
  end
end
