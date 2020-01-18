import json

f = open('trees.json', 'r')
data = json.loads(f.read())
f.close()

trees = data['trees']

formatted_trees = {}

for tree in trees:
  uid = tree['UID']
  tree.pop('UID')
  formatted_trees[uid] = tree

k = open('formatted_trees.json', 'w', encoding='utf-8')
json.dump(formatted_trees, k, ensure_ascii=False, indent=4)
k.close()