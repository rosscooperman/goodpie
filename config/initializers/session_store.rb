# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_goodpie_session',
  :secret      => '4fed3e596773d88d60912c3ca1b7cd8a249ee891d897738dbe02988eddffb53ff28b31d6c142f4cadf31115f2af9e8aaccb7fef37b7e34e0ef5a98a2cbe948a5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
