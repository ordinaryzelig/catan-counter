desc 'install locally'
task :install => ['db:migrate', 'db:seed'] do
end
