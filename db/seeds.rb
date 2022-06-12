# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

gocase = Enterprise::Create.one(name: "Gocase")
root = gocase.root_division

br, =
  Division::Create.many([
    { parent: root, name: "Br" },
    { parent: root, name: "Global" }
  ])

extrema, = Division::Create.many([
  { parent: br, name: "Extrema" },
  { parent: br, name: "Loja Iguatemi" },
  { parent: br, name: "Loja Escritório" }
])

Core::Inventory.create([
  { division: extrema,  name: "Estoque Extrema" },
  { division: extrema,  name: "Almox" },
  { division: extrema,  name: "Produção" }
])

# products = JSON.parse(File.read("db/products.json"))
# products.each { |prod| prod.merge!(enterprise_id: gocase.id, mode: 0) }
# Core::Product.insert_all(products)

# Core::Inventory.all.each do |inventory|
#   Core::Product.all.each do |product|
#     inventory.inventory_products.create(product: product, quantity: (rand * 2000).to_i)
#   end
# end

montadora = Enterprise::Create.one(name: "Montadora")

root = montadora.root_division
br, =
  Division::Create.many([
    { parent: root, name: "Br" },
    { parent: root, name: "Uk" }
  ])

sp, = Division::Create.many([
  { parent: br, name: "SP" },
  { parent: br, name: "CE" },
  { parent: br, name: "RJ" }
])

inventories = Core::Inventory.create([
  { division: sp,  name: "Inventário Santos" },
  { division: sp,  name: "Inventário Capital" }
])

products = montadora.products.create([
  { name: "Carro Preto", mode: :virtual, code: "carro-branco" },
  { name: "Carro Branco", mode: :virtual, code: "carro-preto" },
  { name: "Carro", mode: :virtual, code: "carro" },
  { name: "Motor", mode: :virtual, code: "motor" },
  { name: "Carroceria", code: "chassi" },
  { name: "Roda", code: "roda" },
  { name: "Bloco", code: "bloco" },
  { name: "Cilindro", code: "cilindro" }
])

inventories.each do |inventory|
  products.each do |product|
    quantity = product.virtual? ? 0 : (rand * 100).to_i

    inventory.inventory_products.create(product:, quantity:)
  end
end

preto, branco, carro, motor, carroceria, roda, bloco, cilindro = products
ProductRelation::Create.many([
  { parent: preto, child: carro, mode: :alias },
  { parent: branco, child: carro, mode: :alias },
  { parent: carro, child: motor, mode: :component },
  { parent: carro, child: carroceria, mode: :component },
  { parent: carro, child: roda, mode: :component, quantity: 4 },
  { parent: motor, child: bloco, mode: :component },
  { parent: motor, child: cilindro, mode: :component, quantity: 8 }
])

virt, = Core::VirtualInventory.create([
  { division: br,  name: "Inventário Br (virtual)" }
])

virt.inventories << inventories.first << inventories.second

user = montadora.users.create(username: "matheuziz", password: "12345678")

user.user_sessions.create(token: SecureRandom.hex(128), expires_at: 1.day.from_now)
