user = User.create!(email: 'jeffe.bernal@gmail.com', password: 'test1234')
company = user.companies.create!(email: 'njoy@njoy.com', password: 'test1234', name: 'hotwings')
category = company.categories.create!(name: 'licores fuertes', description: 'licores para fiestas')
supplier = company.suppliers.create!(identification: Faker::Company.spanish_organisation_number,
                                     name: Faker::Company.name, city: Faker::Address.city,
                                     address: Faker::Address.full_address,
                                     phone: Faker::PhoneNumber.phone_number,
                                     contact_name: Faker::Name.name)
company.products.create!(name: 'aguardiente', description: 'el mejor licor de antioquia',
                         supplier: supplier, brand: 'fabrica de licores de antioquia',
                         category: category, quantity: 30, price: 25_000)
company.products.create!(name: 'ron', description: 'el mejor licor de antioquia', quantity: 30,
                         price: 25_000, brand: 'fabrica de licores de antioquia',
                         category: category, supplier: supplier)
company.employees.create!(names: 'jefferson', last_names: 'bernal cardona', city: 'Medellin',
                          address: 'calle 19 #47 - 15', state: 'Antioquia', phone: '2798984',
                          identification: '112849045', email: 'jeffebernalster@gmail.com',
                          birthday: '01/09/1990', start_date: Date.today, password: '1234')
5.times do
  company.employees.create!(names: Faker::Name.name, last_names: Faker::Name.last_name,
                            address: Faker::Address.full_address, state: Faker::Address.state,
                            city: Faker::Address.city, identification: Faker::Number.number(10),
                            phone: Faker::PhoneNumber.cell_phone, email: Faker::Internet.email,
                            birthday: Faker::Date.between(60.years.ago, 18.years.ago),
                            start_date: Faker::Date.between(1.years.ago, Date.today),
                            password: Faker::Number.unique.number(5))
end
