import argparse
import collections
import math
import operator
import pickle
import random

def potential_leaf_node(data):
  count = collections.Counter([i[-1] for i in data])
  return count.most_common(1)[0]

def entropy(data):
  frequency = collections.Counter([item[-1] for item in data])
  def item_entropy(category):
    ratio = float(category) / len(data)
    return -1 * ratio * math.log(ratio, 2)
  return sum(item_entropy(c) for c in frequency.values())

def best_feature_for_split(data):
  baseline = entropy(data)
  def feature_entropy(f):
    def e(v):
      partitioned_data = [d for d in data if d[f] == v]
      proportion = (float(len(partitioned_data)) / float(len(data)))
      return proportion * entropy(partitioned_data)
    return sum(e(v) for v in set([d[f] for d in data]))
  features = len(data[0]) - 1
  information_gain = [baseline - feature_entropy(f) for f in range(features)]
  best_feature, best_gain = max(enumerate(information_gain),
                    key=operator.itemgetter(1))
  return best_feature

def create_tree(data, label):
  category, count = potential_leaf_node(data)
  if count == len(data):
    return category
  node = {}
  feature = best_feature_for_split(data)
  feature_label = label[feature]
  node[feature_label]={}
  classes = set([d[feature] for d in data])
  for c in classes:
    partitioned_data = [d for d in data if d[feature]==c]
    node[feature_label][c] = create_tree(partitioned_data, label)
  return node

def classify(tree, label, data):
  root = list(tree.keys())[0]
  node = tree[root]
  index = label.index(root)
  for k in node.keys():
    if data[index] == k:
      if isinstance(node[k], dict):
        return classify(node[k], label, data)
      else:
        return node[k]

def as_rule_str(tree, label, ident=0):
  space_ident = '  '*ident
  the_string = space_ident
  root = list(tree.keys())[0]
  node = tree[root]
  index = label.index(root)
  for k in node.keys():
    the_string +=  'if ' + label[index] + ' = ' + str(k)
    if isinstance(node[k], dict):
      the_string += ':\n' + space_ident  + as_rule_str(node[k], label, ident + 1)
    else:
      the_string += ' then '  + str(node[k]) + ('.\n' if ident == 0 else ', ')
  if the_string[-2:] == ', ':
    the_string = the_string[:-2]
  the_string += '\n'
  return the_string

def find_edges(tree, label, X, Y):
  X.sort()
  Y.sort()
  diagonals = [i for i in set(X).intersection(set(Y))]
  diagonals.sort()
  L = [classify(tree, label, [d, d]) for d in diagonals]
  low = L.index(False)
  min_x = X[low]
  min_y = Y[low]

  high = L[::-1].index(False)
  max_x = X[len(X)-1 - high]
  max_y = Y[len(Y)-1 - high]

  return (min_x, min_y), (max_x, max_y)

if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument("--datafile")
  args = parser.parse_args()

  try:
    datalist = []
    if args.datafile:
      with open(args.datafile, 'rb') as f:
        datalist = pickle.load(f)
        print (datalist[0])
        label=['x'+str(i) for i in range(1, len(datalist[0])+1)]
        label[0]='x'
        label.append("y")
        tree = create_tree(datalist, label)
        print (tree)
        print (as_rule_str(tree, label))
        print(find_edges(tree, label, [x[0] for x in datalist], [x[0] for x in datalist]))
    else:
      args = parser.parse_args()
      quit()
  except KeyError as ke:
    print (ke)
    parser.print_help()
