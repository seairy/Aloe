namespace :db do
  desc 'Reset the database structure then rebuild and load the seed data'
  task :rebuild do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end