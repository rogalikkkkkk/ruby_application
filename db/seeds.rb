# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Image.destroy_all
Theme.destroy_all
User.destroy_all

Theme.create([

               { name: "-----" }, # 1 Нет темы
               { name: "Этот автомобиль соответствует визуально классу гиперкаров?" }, # 2
               { name: "Этот автомобиль соответствует визуально классу гиперкаров?" }, # 3
               { name: "Этот автомобиль соответствует визуально классу ультракаров?" }, # 4
             ])

Image.create([

               { name: 'Honda NSX NA2', file: 'honda.jpg', theme_id: 1 },
               { name: 'Porsche 918 Spyder', file: 'porsche.jpg', theme_id: 2 },
               { name: 'Rimac Nevera', file: 'rimac.jpg', theme_id: 3 },
               { name: 'Pagani Zonda', file: 'pagani.jpg', theme_id: 4 },
             ])


User.create([

              { name: "Example User", email: "example@railstutorial.org" }, ### TODO: Добавить в таблицу пользователей столбцы с паролем и подтверждением?
            # {name: "Example User", email: "example@railstutorial.org", password: "222222", password_confirmation: "222222"},

            ])

