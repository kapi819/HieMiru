class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  include ContentHelper
  
  def top; end

  def terms; end

  def privacy; end
end
