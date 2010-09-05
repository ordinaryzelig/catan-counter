desc 'install locally'
task :install do
  Rails.env = 'production'
  sh 'rake db:migrate'
  sh 'rake db:seed'
end
