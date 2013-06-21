# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Loki::Application.config.secret_key_base = 'a950a1aacfe6f50a92cf080d228c21eb210c6579967408eb9baea98023e7c603352e818bf34419ad1da3d0bd862075d55326d283895ab0b0571eb0365335634a'
