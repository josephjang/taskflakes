# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_taskflakes_session',
  :secret      => 'bc5a3acab3ce1f5464c2ca56e5fc28eaef5a0ce0341449f32872ed8f1b0ada36ac4091ae9c963d354eef797a7de6b42c9108bc9d3eaaba70547d2d97f12f520f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
