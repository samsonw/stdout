# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_stdout.fastcgi_session',
  :secret      => 'aac26f4351cb9cac47ffd8d445a49794ed53c08e49b22d0fbe41c2cb2278b26d21d17a82ada38eedd04ffa893593d9779879c4b8a3142f7a45a78ad0f5a61c7d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
