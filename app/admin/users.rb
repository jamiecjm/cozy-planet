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
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

ActiveAdmin.register User do
  permit_params :name, :mobile_no, :email, :password, :password_confirmation, :user_type, :admin

  batch_action :destroy, false

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :mobile_no
    column :user_type
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :mobile_no
      row :user_type
      row :current_sign_in_at
      row :sign_in_count
      row :created_at
    end
  end

  filter :name
  filter :email
  filter :mobile_no
  filter :user_type

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :email
      f.input :mobile_no
      f.input :user_type
      # f.input :password
      # f.input :password_confirmation
      if current_user.admin?
        f.input :admin
      end
    end
    f.actions
  end

end
