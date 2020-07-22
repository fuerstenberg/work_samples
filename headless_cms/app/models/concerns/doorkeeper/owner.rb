module Concerns::Doorkeeper::Owner

  extend ActiveSupport::Concern

  included do
    has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner, inverse_of: :owner, autosave: true, dependent: :destroy

    before_validation :build_oauth_application
  end

  def build_oauth_application
    if self.oauth_applications.empty?
      if self.is_a?(Customer)
        scopes = [:admin, :write]
      else
        scopes = [:public]
      end
      self.oauth_applications.build name: self.name, redirect_uri: "urn:ietf:wg:oauth:2.0:oob", scopes: scopes
    end
  end

end
