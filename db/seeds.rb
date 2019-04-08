user = User.create!(email: 'jeffe.bernal@gmail.com', password: 'test1234')
company = user.companies.create!(email: 'njoy@njoy.com', password: 'test1234', name: 'hotwings')
category = company.categories.create!(name: 'licores fuertes', description: 'licores para fiestas')
supplier = company.suppliers.create!(identification: Faker::Company.spanish_organisation_number,
                                     name: Faker::Company.name, city: Faker::Address.city,
                                     address: Faker::Address.full_address,
                                     phone: Faker::PhoneNumber.phone_number,
                                     contact_name: Faker::Name.name)
company.products.create!(name: 'aguardiente', quantity: 30, price: 25_000, supplier: supplier,
                         brand: 'fabrica de licores de antioquia', category: category)
company.products.create!(name: 'ron', quantity: 30, price: 25_000, supplier: supplier,
                        brand: 'fabrica de licores de antioquia', category: category)
