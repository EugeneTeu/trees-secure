import requests, json
from bs4 import BeautifulSoup

f = open('html.json', 'r')
data = json.loads(f.read())
f.close()

def analyse(page):
  html = page['html']
  soup = BeautifulSoup(html, 'html.parser')

  # Get image
  try:
    image = soup.find(class_="banner-image")
    src = 'https://www.nparks.gov.sg' + image.get('data-src')
    page['image'] = src
  except:
    page['image'] = None

  # Get description
  temp_description = soup.find(class_="column description")
  description = BeautifulSoup(str(temp_description), 'html.parser').get_text("\n", strip=True)
  page['description'] = description

  side_info = soup.find_all(class_="aside-info-block")

  # Get UID
  try:
    temp_uid = side_info[0]
    uid = BeautifulSoup(str(temp_uid), 'html.parser').get_text(strip=True).replace('Unique ID for Heritage Tree', '')
    page['uid'] = uid
  except:
    page['uid'] = None

  # Get location
  try:
    temp_location = side_info[1]
    location = BeautifulSoup(str(temp_location), 'html.parser').get_text("", strip=True).replace('Location', '').replace('Get Directions', '')
    page['location'] = location
  except:
    page['location'] = None

  # Get scientific name, common name, girth, height
  try:
    temp_info = side_info[2]
    info = BeautifulSoup(str(temp_info), 'html.parser').get_text("\n", strip=True)
    details = info.split('\n')
    try:
      scientific_name = details[2]
      page['scientific_name'] = scientific_name
    except:
      page['scientific_name'] = None

    try:
      common_name = details[4]
      page['common_name'] = common_name
    except:
      page['common_name'] = None

    try:
      girth = details[6]
      page['girth'] = girth
    except:
      page['girth'] = None

    try:
      height = details[8]
      page['height'] = height
    except:
      page['height'] = None

  except:
    page['scientific_name'] = None
    page['common_name'] = None
    page['girth'] = None
    page['height'] = None

  return page

trees = []

for page in data:
  trees.append(analyse(page))

data = {}

for tree in trees:
  datum = {}
  datum['link'] = tree['url']
  datum['coordinates'] = tree['coordinates']
  datum['image'] = tree['image']
  datum['description'] = tree['description']
  datum['location'] = tree['location']
  datum['scientific_name'] = tree['scientific_name']
  datum['common_name'] = tree['common_name']
  datum['girth'] = tree['girth']
  datum['height'] = tree['height']
  uid = tree['uid']
  data[uid] = datum

o = open('trees.json', 'w', encoding='utf-8')
json.dump(data, o, ensure_ascii=False, indent=4)
o.close()
