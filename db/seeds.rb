user = User.create!(email: 'jeffe.bernal@gmail.com', password: 'test1234')
company = user.companies.create!(email: 'njoy@njoy.com', password: 'test1234', name: 'hotwings',
                                 phone: Faker::PhoneNumber.phone_number,
                                 identification: Faker::Number.number(10))
20.times do
  supplier = company.suppliers.create!(name: Faker::Lorem.word, city: Faker::Address.city,
                                       address: Faker::Address.full_address,
                                       phone: Faker::PhoneNumber.phone_number,
                                       identification: Faker::Company.spanish_organisation_number,
                                       contact_name: Faker::Name.name)
  category = company.categories.create!(name: Faker::Lorem.unique.word,
                                        description: Faker::Lorem.sentence)
  5.times do
    company.products.create!(name: Faker::Lorem.unique.word, quantity: rand(99),
                             description: Faker::Lorem.sentence, brand: Faker::Lorem.word,
                             category: category, supplier: supplier, price: rand(9_999))
  end
end
products = company.products
menu_categories = []
menu_categories << company.categories
                          .create!(name: 'Platos Fuertes', description: Faker::Lorem.sentence)
menu_categories << company.categories.create(name: 'Entradas', description: Faker::Lorem.sentence)
menu_categories << company.categories.create(name: 'Sushi', description: Faker::Lorem.sentence)
menu_categories << company.categories.create(name: 'Frutas', description: Faker::Lorem.sentence)
menu_categories << company.categories.create(name: 'Ensaladas', description: Faker::Lorem.sentence)

20.times do |index|
  if index < 8
    name = Faker::Food.unique.dish
    menu = company.menus.create(
      name: name, price: rand(99_999), category: menu_categories[rand(2)],
      menu_items: [MenuItem.create(quantity: rand(9), product: products.sample)]
    )
  elsif index >= 8 && index < 12
    menu = company.menus.create(
      name: Faker::Food.unique.sushi, price: rand(99_999), category: menu_categories[2],
      menu_items: [MenuItem.create(quantity: rand(9), product: products.sample)]
    )
  elsif index >= 12 && index < 16
    menu = company.menus.create(
      name: Faker::Food.unique.fruits, price: rand(99_999), category: menu_categories[3],
      menu_items: [MenuItem.create(quantity: rand(9), product: products.sample)]
    )
  else
    menu = company.menus.create(
      name: Faker::Food.unique.vegetables, price: rand(99_999), category: menu_categories[4],
      menu_items: [MenuItem.create(quantity: rand(9), product: products.sample)]
    )
  end
  rand(1..10).times do
    menu.menu_items.create(quantity: rand(1..10), product: products.sample)
  end
  menu.save!
end
employee = company.employees.create!(names: 'jefferson', last_names: 'bernal cardona',
                                     address: 'calle 19 #47 - 15', state: 'Antioquia',
                                     identification: '112849045', phone: '2798984',
                                     birthday: '01/09/1990', start_date: Date.today,
                                     password: '1234', email: 'jeffebernalster@gmail.com',
                                     role: :admin, city: 'Medellin')
5.times do |index|
  product = products.sample
  number = rand(99)
  company.transaktions.create!(quantity: product.quantity > number ? number : product.quantity,
                               product: product, employee: employee, kind: rand(2))
  company.employees.create!(names: Faker::Name.name, last_names: Faker::Name.last_name,
                            address: Faker::Address.full_address, state: Faker::Address.state,
                            city: Faker::Address.city, identification: Faker::Number.number(10),
                            phone: Faker::PhoneNumber.cell_phone, email: Faker::Internet.email,
                            birthday: Faker::Date.between(60.years.ago, 18.years.ago),
                            start_date: Faker::Date.between(1.years.ago, Date.today),
                            password: Faker::Number.unique.number(5))
  company.boards.create!(number: index + 1, pos_y: 50, pos_x: (100 * (index + 1)),
                         width: 50, height: 50)
  company.boards.create!(number: index * 2, pos_y: 150, pos_x: (200 * (index + 1)),
                         width: 100, height: 100)
  company.boards.create!(number: index * 3, pos_y: 300, pos_x: (220 * index),
                         width: 200, height: 200)
end
