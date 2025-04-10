# config/initializers/cookies.rb
Rails.application.config.action_dispatch.signed_cookie_digest = "SHA256"
Rails.application.config.action_dispatch.cookies_rotations.tap do |cookies|
  cookies.rotate :signed, digest: "SHA1"
end
