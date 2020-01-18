import requests, json

url_coordinate_pairs = []

f = open('heritage-trees-geojson.geojson', 'r')

def getUrl(line):
  start = line.find('HYPERLINK')
  temp = line[start:]
  j = temp.find('<\/td>')
  temp2 = (temp[:j])
  link = temp2[20:]
  url = link.replace('\/', '/')
  return url

def getCoordinates(line):
  b = line.find('coordinates')
  t = line[b+len('coordinates')+3:]
  c = t.find(']')
  q = t[:c+1]
  m = json.loads(q)
  n = []
  n.append(m[1])
  n.append(m[0])
  return str(n)

for line in f:
  url = getUrl(line)
  if len(url) > 0:
    url_coordinate_pairs.append((getUrl(line), getCoordinates(line)))

f.close()

values = list(map(lambda pair : { 'url': pair[0], 'coordinates': pair[1], 'html': requests.get(pair[0]).content.decode() }, url_coordinate_pairs))

output = open('html.json', 'w', encoding='utf-8')
json.dump(values, output, ensure_ascii=False, indent=4)
output.close()
