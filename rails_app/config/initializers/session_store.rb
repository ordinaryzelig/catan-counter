# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_catan_session',
  :secret      => '7f39efd9f449ea6e42eded68cced57f9da1ba61080e689cde7a540ff1409f25dd1fd074b20fdefcd2b17fe69c2566f954993ca514cae8c509b32d38491f61cb3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
