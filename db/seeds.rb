unless User.by_email(email = "juri.semjonov@gmail.com").exists?
  user = User.new(:password => "juri.semjonov", :username => "semjonow")
  user.email = email
  user.root  = true
  user.save!
end