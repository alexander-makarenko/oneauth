User.create!(
  first_name: 'John',
  last_name: 'Doe',
  email: 'admin@example.com',
  password: 'qwerty',
  password_confirmation: 'qwerty',
  admin: true
)

49.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.safe_email
  password = Faker::Internet.password(8, 14)

  unless User.exists?(email: email)
    User.create!(
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password,
      password_confirmation: password
    )
  end
end

49.times do |n|  
  Site.create!(
    name: Faker::Lorem.sentence(2, true, 4),
    domain: Faker::Internet.url,
    user_update_callback: Faker::Internet.url,
    auth_token_callback: Faker::Internet.url   
  )
end

Site.first.update(
  secret_key: 'bdd6329e667da077d05893fd068ce3c5ca168858',
  domain: 'http://localhost:3001/',
  user_update_callback: 'http://localhost:3001/user_update_callback',
  auth_token_callback: 'http://localhost:3001/auth_callback'
)