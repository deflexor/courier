# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_WMcourier_rails_session',
  :secret      => '852aef8a4c7a791e435aabcc00de7e116f50696282f467b751aee69ff5a3c15d32f6009e1979e9af2f90795c3e5eff9817171312c775009a47ec4e397bc58867'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
