
import folium
import pandas
import json
import codecs


data = pandas.read_csv("Volcanoes.txt")
lat = list(data["LAT"])
lon = list(data["LON"])
names = list(data["NAME"])
elev = list(data["ELEV"])

def color_producer(i):
    if i < 1000:
        return "green"
    elif 1000 <= i < 3000:
        return "orange"
    else:
        return "red"


'''
def color_producer(elevation):
    if elevation < 1000:
        return 'green'
    elif 1000 <= elevation < 3000:
        return 'orange'
    else:
        return 'red'
'''

mapp = folium.Map()

fgv = folium.FeatureGroup(name="volcanoes")

for lt, ln, el in zip(lat , lon, elev):
    fgv.add_child(folium.Marker(location=[lt , ln], icon= folium.Icon(color=color_producer(el)), popup=str(el)))
    #fg.add_child(folium.Marker(location=[lt, ln], popup=na))
    #fg.add_child(folium.CircleMarker(location=[lt,ln],radius=6,popup=str(el)+" m", fill_color=color_producer(el),color='grey',fill_opacity=0.7))

fgp = folium.FeatureGroup(name="population")



fgp.add_child(folium.GeoJson(data=(json.load(codecs.open('world.json', 'r', 'utf-8-sig'))),
                            style_function=lambda x: {"fillColor":"yellow" if x['properties']['POP2005'] < 10000000
                            else 'blue' if 10000000 <= x['properties']['POP2005'] < 20000000
                            else 'red'}))

mapp.add_child(fgv)
mapp.add_child(fgp)
mapp.add_child(folium.LayerControl())
mapp.save("Map1.html")
