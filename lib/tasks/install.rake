desc 'install locally'
task :install do
  ENV['RAILS_ENV'] = 'production'
  sh 'rake db:migrate'
  sh 'rake db:seed'
end
