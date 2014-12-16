Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'xdAoEBv8iFQKeBwjAWkHbfEW2HcwvsLK',
    '6rSXG6x2PJnCtpwUFVeCLdHP1-drwzg4nFlWkAIIGLguGDn50WCnBAKi4MNYyCMH',
    'jvidalba.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end