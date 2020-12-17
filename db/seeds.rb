# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ServerMonitor.create(name: 'Cobchise', 'url': 'https://crewlink.among-us.tech', region: 'North America', description: "Cobchise's CrewLink Server", available: false, current_users: 0, official: false)
ServerMonitor.create(name: 'Lermatroid', 'url': 'https://crewlink.glitch.me', region: 'North America', description: "Lermatroid's CrewLink Server", available: true, current_users: 285, official: false)
ServerMonitor.create(name: 'Ottomated', 'url': 'https://crewl.ink', region: 'North America', description: "Official CrewLink Server", available: true, current_users: 2000, official: true)
ServerMonitor.create(name: 'The Skeld #1', 'url': 'https://s1.theskeld.xyz', region: 'Oceania', description: "Tito's CrewLink Server", available: true, current_users: 60, official: false)
ServerMonitor.create(name: 'The Skeld #2', 'url': 'https://s2.theskeld.xyz', region: 'North America', description: "Tito's CrewLink Server", available: true, current_users: 47, official: false)
ServerMonitor.create(name: 'The Skeld #3', 'url': 'https://s3.theskeld.xyz', region: 'North America', description: "Tito's CrewLink Server", available: false, current_users: 0, official: false)
ServerMonitor.create(name: 'The Skeld #4', 'url': 'https://s4.theskeld.xyz', region: 'Europe', description: "Tito's CrewLink Server", available: true, current_users: 35, official: false)
ServerMonitor.create(name: 'ubergeek77', 'url': 'https://public2.crewl.ink', region: 'North America', description: "Uber's CrewLink Server", available: true, current_users: 70, official: false)

ServerVersion.create(name: '2020.10.22')
ServerVersion.create(name: '2020.11.17')
ServerVersion.create(name: '2020.12.3')
ServerVersion.create(name: '2020.12.5')
ServerVersion.create(name: '2020.12.9', latest: true)

c = ServerMonitor.where(name: 'Cobchise').first
c.server_versions << ServerVersion.all