module Authenticable
  def self.included(model)
    model.class_eval do
      extend ClassMethods
      include InstanceMethods

      field :username
      field :email
      field :root, :type => Boolean, :default => false
      field :crypted_password
      field :password_salt
      field :persistence_token

      index({:username => 1},          {:unique => true})
      index({:email => 1},             {:unique => true})
      index({:persistence_token => 1}, {:unique => true})

      include Authlogic::ActsAsAuthentic::Base
      include Authlogic::ActsAsAuthentic::Email
      include Authlogic::ActsAsAuthentic::LoggedInStatus
      include Authlogic::ActsAsAuthentic::Login
      include Authlogic::ActsAsAuthentic::MagicColumns
      include Authlogic::ActsAsAuthentic::Password
      include Authlogic::ActsAsAuthentic::PerishableToken
      include Authlogic::ActsAsAuthentic::PersistenceToken
      include Authlogic::ActsAsAuthentic::RestfulAuthentication
      include Authlogic::ActsAsAuthentic::SessionMaintenance
      include Authlogic::ActsAsAuthentic::SingleAccessToken
      include Authlogic::ActsAsAuthentic::ValidationsScope
    end
  end

  module ClassMethods
    def <(klass)
      return true if klass == ::ActiveRecord::Base
      super(klass)
    end

    def column_names
      fields.map &:first
    end

    def quoted_table_name
      'users'
    end

    def primary_key
      # FIXME: Is this check good enough?
      if caller.first.to_s =~ /(persist|session)/
        :_id
      else
        @@primary_key
      end
    end

    def default_timezone
      :utc
    end

    def find_by__id(*args)
      find *args
    end

    # Change this to your preferred login field
    def find_by_username(username)
      where(:username => username).first
    end

    def with_scope(query)
      query = where(query) if query.is_a?(Hash)
      yield query
    end
  end

  module InstanceMethods
    def readonly?
      false
    end
  end
end