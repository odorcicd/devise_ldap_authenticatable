ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  
  def reset_ldap_server!
    `ldapmodify -x -h localhost -p 3389 -D "cn=admin,dc=test,dc=com" -w secret -f ../ldap/clear.ldif`
    `ldapadd -x -h localhost -p 3389 -D "cn=admin,dc=test,dc=com" -w secret -f ../ldap/base.ldif`
  end
  
  def default_devise_settings!
    ::Devise.ldap_logger = true
    ::Devise.ldap_create_user = false
    ::Devise.ldap_update_password = true
    ::Devise.ldap_config = "#{Rails.root}/config/ldap.yml"
    ::Devise.ldap_check_group_membership = false
    ::Devise.ldap_check_attributes = false
    ::Devise.authentication_keys = [:email]
  end
  
end
