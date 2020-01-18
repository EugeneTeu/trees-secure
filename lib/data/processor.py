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
  try:
    temp_description = soup.find(class_="column description")
    description = BeautifulSoup(str(temp_description), 'html.parser').get_text(" ", strip=True)
    page['description'] = description
  except:
    page['description'] = "N/A"
  

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
    page['location'] = "N/A"

  # Get scientific name, common name, girth, height
  try:
    temp_info = side_info[2]
    info = BeautifulSoup(str(temp_info), 'html.parser').get_text("\n", strip=True)
    details = info.split('\n')

    try:
      index = details.index('Scientific name')
      scientific_name = details[index + 1]
      page['scientific_name'] = scientific_name
    except:
      page['scientific_name'] = "N/A"

    try:
      index = details.index('Common name')
      common_name = details[index + 1]
      page['common_name'] = common_name
    except:
      page['common_name'] = "N/A"

    try:
      index = details.index('Girth')
      girth = details[index + 1]
      page['girth'] = girth
    except:
      page['girth'] = "N/A"

    try:
      index = details.index('Height')
      height = details[index + 1]
      page['height'] = height
    except:
      page['height'] = "N/A"

  except:
    page['scientific_name'] = "N/A"
    page['common_name'] = "N/A"
    page['girth'] = "N/A"
    page['height'] = "N/A"

  return page

trees = []

for page in data:
  trees.append(analyse(page))

data = {}

for tree in trees:
  datum = {}
  uid = tree['uid']
  if (uid is not None):
    datum['link'] = tree['url']
    datum['coordinates'] = tree['coordinates']
    datum['image'] = tree['image']
    datum['description'] = tree['description']
    datum['location'] = tree['location']
    datum['scientific_name'] = tree['scientific_name']
    datum['common_name'] = tree['common_name']
    datum['girth'] = tree['girth']
    datum['height'] = tree['height']
    data[uid] = datum

o = open('trees.json', 'w', encoding='utf-8')
json.dump(data, o, ensure_ascii=False, indent=4)
o.close()
