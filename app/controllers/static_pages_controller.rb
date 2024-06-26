class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, except: :menu
  include ContentHelper
  
  def top; end

  def terms; end

  def privacy; end

  def menu; end
end
