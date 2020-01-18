import requests, json

values = []

f = open('heritage-trees-geojson.geojson', 'r')
for x in f:
  i = x.find('HYPERLINK')
  t1 = x[i:]
  j = t1.find('<\/td>')
  t2 = (t1[:j])
  link = t2[20:]
  url = link.replace('\/', '/')
  if len(url) > 0:
    b = x.find('coordinates')
    t = x[b+len('coordinates')+3:]
    c = t.find(']')
    q = t[:c+1]
    values.append((url, q))
  
f.close()

trees = {}

def scrape(link, coordinates):
  r = requests.get(url=link)

  html = r.content.decode()

  a1 = html.find('<div class="column description">')
  t1 = html[a1+len('<div class="column description">'):]
  a2 = t1.find('</div>')
  description = (t1[:a2].strip())[3:-4].replace('<br>', ' ')

  a3 = t1.find('<div class="aside-info-block">')
  t2 = t1[a3+len('<div class="aside-info-block">'):]
  a4 = t2.find('</div>')
  t3 = t2[:a4].strip()
  a5 = t3.find('<p>')
  a6 = t3.find('</p>')
  uid = t3[a5+len('<p>'):a6]

  a7 = t2.find('<div class="aside-info-block">')
  t4 = t2[a7:]
  a8 = t4.find('</div>')
  t5 = t4[:a8]
  a9 = t5.find('</h2>')
  a10 = t5.find('<p')
  location = t5[a9+len('</h2>'):a10].strip()

  a11 = t4.find('<div class="aside-info-block basic-info">')
  t6 = t4[a11:]
  a12 = t6.find('</div>')
  t7 = t6[:a12]

  a13 = t7.find('<dd>')
  t8 = t7[a13+len('<dd>'):]
  a14 = t8.find('</dd>')
  t9 = t8[:a14]
  a15 = t9.find('<i>')
  a16 = t9.find('</i>')
  scientific_name = t8[a15+len('<i>'):a16].strip()

  a17 = t8.find('<dd>')
  t10 = t8[a17+len('<dd>'):]
  a18 = t10.find('</dd>')
  common_name = t10[:a18].strip()

  a19 = t10.find('<dd>')
  t11 = t10[a19+len('<dd>'):]
  a20 = t11.find('</dd>')
  girth = t11[:a20].strip()

  a21 = t11.find('<dd>')
  t12 = t11[a21+len('<dd>'):]
  a22 = t12.find('</dd>')
  height = t12[:a22].strip()

  trees[uid] = {
    'link': link,
    'coordinates': coordinates,
    'description': description,
    'location:': location,
    'scientific_name:': scientific_name,
    'common_name:': common_name,
    'girth:': girth,
    'height': height
  }

# scrape('https://www.nparks.gov.sg/gardens-parks-and-nature/heritage-trees/ht-2015-235')

for (url, coor) in values:
  print(url)
  scrape(url, coor)

k = open('trees2.json', 'w', encoding='utf-8')
json.dump(trees, k, ensure_ascii=False, indent=4)
k.close()