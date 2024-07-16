# frozen_string_literal: true

# StaticPagesController handles the static pages of the application.
# It manages actions related to static content like the home page, about page, etc.

class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, except: :menu
  include ContentHelper

  def top; end

  def terms; end

  def privacy; end

  def menu; end
end
