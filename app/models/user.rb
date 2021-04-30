class User < ActiveRecord::Base
    has_many :journals
end