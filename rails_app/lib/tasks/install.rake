desc 'install locally'
task :install => ['db:drop', 'db:migrate', 'db:seed'] do
end
