# frozen_string_literal: true

# ApplicationRecord is the base class for all models in the application.
# All models should inherit from ApplicationRecord to share common functionality.

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
