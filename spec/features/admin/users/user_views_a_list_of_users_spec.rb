require 'rails_helper'

feature 'User views a list of users' do
  background { sign_in_with(current_user.email, current_user.password) }
  given(:current_user) { create(:user, :admin) }

  # NB: We would need filtering to be present for this to work
  # context 'when there are no users' do
  #   scenario 'they see no users found' do
  #     visit admin_users_path
  #
  #     expect(page).to have_content(I18n.t('admin.users.index.none_found'))
  #   end
  # end

  context 'when there are users' do
    given!(:users) { create_list(:user, 3, :moderator) }

    scenario 'they see users' do
      visit admin_users_path

      expect_user_row users[0]
      expect_user_row users[1]
      expect_user_row users[2]
    end
  end

  def expect_user_row(user)
    [
      :name,
      :email,
      :role_name,
      :is_active
    ].each do |attribute|
      expect(page).to have_content(user.send(attribute))
    end
  end
end