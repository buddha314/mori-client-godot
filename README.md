# Mori Client in Godot

Mori is the new logic layer, let's build a client in Godot!

## Connection List

Looks like this

```
[
	{ "from_node": &"factnode_0", "from_port": 0, "to_node": &"relation_0", "to_port": 0, "keep_alive": false },
	{ "from_node": &"relation_0", "from_port": 0, "to_node": &"rulenode_0", "to_port": 0, "keep_alive": false },
	{ "from_node": &"factnode_1", "from_port": 0, "to_node": &"relation_0", "to_port": 1, "keep_alive": false }, 
	{ "from_node": &"relation_1", "from_port": 0, "to_node": &"rulenode_0", "to_port": 1, "keep_alive": false }
]
```

## Early Version of Graph Output

```
{ "client": "mori-godot", "nodes": { &"factnode_0": { "class": "GraphNode", "data": { "fact": "eath", "probability": "1.0" } }, &"factnode_1": { "class": "GraphNode", "data": { "fact": "flood", "probability": "1.0" } }, &"relation_0": { "class": "GraphNode", "data": { "arity_types": ["str", "str"], "relation": "disaster" } }, &"rulenode_0": { "class": "GraphNode", "data": <null> }, &"relation_1": { "class": "GraphNode", "data": { "arity_types": ["str", "str"], "relation": "crime" } }, &"factnode_2": { "class": "GraphNode", "data": { "fact": "burglary", "probability": "1.0" } } }, "edges": [{ "from_node": &"factnode_0", "from_port": 0, "to_node": &"relation_0", "to_port": 0, "keep_alive": false }, { "from_node": &"factnode_1", "from_port": 0, "to_node": &"relation_0", "to_port": 1, "keep_alive": false }, { "from_node": &"relation_0", "from_port": 0, "to_node": &"rulenode_0", "to_port": 0, "keep_alive": false }, { "from_node": &"relation_1", "from_port": 0, "to_node": &"rulenode_0", "to_port": 1, "keep_alive": false }, { "from_node": &"factnode_2", "from_port": 0, "to_node": &"relation_1", "to_port": 0, "keep_alive": false }] }
```
