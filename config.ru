require './config/environment'

# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

use Rack::MethodOverride

use JournalController #=> This is mounting the User class to the ApplicationController so that it know's about it
use UserController #=> This is mounting the User class to the ApplicationController so that it know's about it
run ApplicationController
