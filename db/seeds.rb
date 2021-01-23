# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([{ title: 'cpus' }, { title: 'mother_boards' }, { title: 'graphics_cards', countable: true }, { title: 'memory', countable: true }, { title: 'hard_drive', countable: true }, { title: 'SSD', countable: true }, { title: 'monitor', countable: true }, { title: 'cases' }, { title: 'power_supply' }, { title: 'mouse' }, { title: 'keyboard' }, { title: 'webcams' }, { title: 'fans_&_cooling' }, { title: 'network_cards' }, { title: 'sound_cards' }, { title: 'capture_cards' }, { title: 'services' }
                ])