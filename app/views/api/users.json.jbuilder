json.pages @users.total_pages
json.users @users, partial: 'api/partial/user', as: :user
