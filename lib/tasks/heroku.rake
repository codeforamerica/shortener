namespace :heroku do
  desc 'Heroku release tasks (runs on every code push, before postdeploy task on review app creation)'
  task release: :environment do
    if ActiveRecord::SchemaMigration.table_exists?
      Rake::Task['db:migrate'].invoke
    else
      message = "Database not initialized, skipping database migrations."
      Rails.logger.info(message)
      $stdout.puts(message) unless ActiveSupport::Logger.logger_outputs_to?(Rails.logger, STDOUT)
    end
  end

  desc 'Heroku postdeploy tasks (runs only on review app creation, after release task)'
  task postdeploy: :environment do
    Rake::Task['db:schema:load'].invoke
    Rake::Task['db:seed'].invoke
  end
end
