# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# seed panel providers
pp1 = PanelProvider.create({code: 'LettersPanelProvider'})
pp2 = PanelProvider.create({code: 'ArraysPanelProvider'})
pp3 = PanelProvider.create({code: 'NodesPanelProvider'})

# seed countries
country1 = Country.create({country_code: "USA", panel_provider: pp1})
country2 = Country.create({country_code: "Russia", panel_provider: pp2})
country3 = Country.create({country_code: "China", panel_provider: pp3})

# seed target group trees
tg_tree1 = TargetGroup.find_or_create_by_path([
    {name: "Root_TG1", panel_provider: pp1},
    {name: "TG1_level_1", panel_provider: pp1},
    {name: "TG1_level_2", panel_provider: pp1},
    {name: "TG1_level_3", panel_provider: pp1},
    {name: "TG1_level_4", panel_provider: pp1}
  ]
)
tg_tree2 = TargetGroup.find_or_create_by_path([
    {name: "Root_TG2", panel_provider: pp2},
    {name: "TG2_level_1", panel_provider: pp2},
    {name: "TG2_level_2", panel_provider: pp2},
    {name: "TG2_level_3", panel_provider: pp2},
    {name: "TG2_level_4", panel_provider: pp2}
  ]
)
tg_tree3 = TargetGroup.find_or_create_by_path([
    {name: "Root_TG3", panel_provider: pp3},
    {name: "TG3_level_1", panel_provider: pp3},
    {name: "TG3_level_2", panel_provider: pp3},
    {name: "TG3_level_3", panel_provider: pp3},
    {name: "TG3_level_4", panel_provider: pp3}
  ]
)
tg_tree4 = TargetGroup.find_or_create_by_path([
    {name: "Root_TG4", panel_provider: pp2},
    {name: "TG4_level_1", panel_provider: pp2},
    {name: "TG4_level_2", panel_provider: pp2},
    {name: "TG4_level_3", panel_provider: pp2},
    {name: "TG4_level_4", panel_provider: pp2}
  ]
)

# seed country_target_groups, i.e. relationship between target groups and countries
country1.target_groups << tg_tree1.root
country1.save!

country2.target_groups = [tg_tree2.root, tg_tree4.root]
country2.save!

country3.target_groups << tg_tree3.root
country3.save!

# seed location groups
lg1 = LocationGroup.create({name: "chineese locations", country: country3, panel_provider: pp3})
lg2 = LocationGroup.create({name: "russian locations", country: country2, panel_provider: pp2})
lg3 = LocationGroup.create({name: "usa cities", country: country1, panel_provider: pp1})
lg4 = LocationGroup.create({name: "usa states", country: country1, panel_provider: pp3})

# seed locations
# Locations for china
l1 = Location.create({name: "Hong Kong"})
l2 = Location.create({name: "Shanghai"})
l3 = Location.create({name: "Guangzhou"})
l4 = Location.create({name: "Dong Cheng District, Beijing"})

# Locations for Russia
l5 = Location.create({name: "Moscow"})
l6 = Location.create({name: "St. Petersburg"})
l7 = Location.create({name: "Krasnodar"})
l8 = Location.create({name: "Samara"})
l9 = Location.create({name: "Novgorod District"})
l10 = Location.create({name: "Samara District"})

# Locations for USA
l11 = Location.create({name: "San Francisco"})
l12 = Location.create({name: "Seattle"})
l13 = Location.create({name: "New York"})
l14 = Location.create({name: "New Jersey"})
l15 = Location.create({name: "Chicago"})
l16 = Location.create({name: "Boston"})

l17 = Location.create({name: "California"})
l18 = Location.create({name: "Illinois"})
l19 = Location.create({name: "Alaska"})
l20 = Location.create({name: "Washington"})

# seed location_location_groups, i.e. relationships between location and location groups
lg1.locations = [l1, l2, l3, l4]
lg1.save!
lg2.locations = [l5, l6, l7, l8, l9, l10]
lg2.save!
lg3.locations = [l11, l12, l13, l14, l15, l16]
lg3.save!
lg4.locations = [l17, l18, l19, l20]
lg4.save!