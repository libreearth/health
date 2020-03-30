import {Map, View} from 'ol'
import {Tile as TileLayer, Vector as VectorLayer} from 'ol/layer'
import {OSM, Vector as VectorSource} from 'ol/source'
import {Style, Stroke, Fill} from 'ol/style'
import GeoJSON from 'ol/format/GeoJSON'
import geojson2h3 from 'geojson2h3'
import * as _ from "lodash"

styleFunction = (feature, min, max) -> 
  color = perc2color(feature.get("value"), min, max)
  return new Style({
    stroke: new Stroke({
      color: color,
      width: 2
    }),
    fill: new Fill({
      color: color
    })
  })

perc2color = (perc,min,max) ->
  base = (max - min);
  perc = if base == 0 then  100 else (perc - min) / base * 100
  if perc < 50
    r = 255;
    g = Math.round(5.1 * perc)
  else 
    g = 255;
    r = Math.round(510 - 5.10 * perc)
  b = 0

  h = r * 0x10000 + g * 0x100 + b * 0x1
  '#' + ('000000' + h.toString(16)).slice(-6) + '99'
        
init_map = (evaluations) ->
  geojson = geojson2h3.h3SetToFeatureCollection(_.map(evaluations, "hexagon"), (id3) -> {value: _.find(evaluations, (evaluation) -> evaluation.hexagon == id3).value})

  vectorSource = new VectorSource({
    features: (new GeoJSON()).readFeatures(geojson)
  })
  min = _.min(_.map(evaluations, "value"))
  max = _.max(_.map(evaluations, "value"))
  vectorLayer = new VectorLayer({
    source: vectorSource,
    style: (val) -> styleFunction(val, min, max)
  })
  initCoord = geojson.features[0]?.geometry.coordinates[0][0]
  initCoord = if initCoord? then initCoord else [-122.4, 37.7923539]
  new Map({
    target: 'map',
    layers: [
      new TileLayer({
        source: new OSM()
      }),
      vectorLayer
    ],
    view: new View({
      projection: 'EPSG:4326',
      center: initCoord,
      zoom: 13
    })
  })

module.exports = {init_map}