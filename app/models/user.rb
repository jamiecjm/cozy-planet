# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  mobile_no              :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_type              :string(255)
#  admin                  :boolean          default(FALSE)
#  welcomed_at            :datetime
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
	extend Enumerize
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, 
	     :recoverable, :rememberable, :trackable, :validatable,
	     :confirmable


  	has_many :units, dependent: :destroy
  	has_many :bookings, through: :units

  	enumerize :user_type, in: ['Owner', 'Operator']

  	scope :owner, ->{where(user_type: 'Owner')}
  	scope :operator, ->{where(user_type: 'Operator')}

  	before_validation :generate_password, if: proc {new_record?}

    after_save :send_welcome_email

  	def owner?
  		user_type == 'Owner'
  	end

  	def operator?
  		user_type == 'Operator'
  	end

    def skip_welcome!
      user.welcomed_at = Time.now
    end

    private

  	def generate_password
  		self.password = Devise.friendly_token.first(8)
  	end

    def send_welcome_email
      if confirmed_at_changed? && confirmed_at.present? && welcomed_at.nil?
        raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
        self.reset_password_token   = enc
        self.reset_password_sent_at = Time.now
        self.welcomed_at = Time.now
        self.save(validate: false)
        UserMailer.welcome(self, raw).deliver
      end
    end
  
end
