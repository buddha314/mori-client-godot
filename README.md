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
{
  "client": "mori-godot",
  "edges": [
	{
	  "from_node": "factnode_0",
	  "from_port": 0,
	  "keep_alive": false,
	  "to_node": "relation_0",
	  "to_port": 0
	},
	{
	  "from_node": "factnode_1",
	  "from_port": 0,
	  "keep_alive": false,
	  "to_node": "relation_0",
	  "to_port": 1
	},
	{
	  "from_node": "factnode_2",
	  "from_port": 0,
	  "keep_alive": false,
	  "to_node": "relation_1",
	  "to_port": 0
	},
	{
	  "from_node": "relation_0",
	  "from_port": 0,
	  "keep_alive": false,
	  "to_node": "rulenode_0",
	  "to_port": 0
	},
	{
	  "from_node": "relation_1",
	  "from_port": 0,
	  "keep_alive": false,
	  "to_node": "rulenode_0",
	  "to_port": 1
	}
  ],
  "nodes": {
	"factnode_0": {
	  "class": "GraphNode",
	  "data": {
		"fact": "quake",
		"logic_class": "fact",
		"probability": "0.1"
	  }
	},
	"factnode_1": {
	  "class": "GraphNode",
	  "data": {
		"fact": "flood",
		"logic_class": "fact",
		"probability": "0.2"
	  }
	},
	"factnode_2": {
	  "class": "GraphNode",
	  "data": {
		"fact": "burglary",
		"logic_class": "fact",
		"probability": "0.3"
	  }
	},
	"relation_0": {
	  "class": "GraphNode",
	  "data": {
		"arity_types": [
		  "str",
		  "str"
		],
		"logic_class": "relation",
		"relation": "disaster"
	  }
	},
	"relation_1": {
	  "class": "GraphNode",
	  "data": {
		"arity_types": [
		  "str",
		  "str"
		],
		"logic_class": "relation",
		"relation": "crime"
	  }
	},
	"rulenode_0": {
	  "class": "GraphNode",
	  "data": {
		"logic_class": "rule_and",
		"relation": "alarm"
	  }
	}
  }
}
```
