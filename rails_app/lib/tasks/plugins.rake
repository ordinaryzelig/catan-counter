namespace :plugins do
  
  desc 'install git submodule plugins'
  task :install do
    Dir.chdir '../../' do
      sh 'git submodule init'
      sh 'git submodule update'
    end
  end
  
end
