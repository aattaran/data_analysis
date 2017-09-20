import folium
mapp = folium.Map(location=[37, -122])

fg = folium.FeatureGroup(name="my map")

for ij in [[37, -122],[37.2, -122.1]]:
    fg.add_child(folium.Marker(location=ij, popup=" SFSU"))

mapp.add_child(fg)
mapp.save("Map1.html")
