initial_nodes = [
  {content: '0', node_id: 0, left: 1, right: 3, parent: nil},
  {content: '1', node_id: 1, left: 2, right: nil, parent: 0},
  {content: '2', node_id: 2, left: nil, right: nil, parent: 1},
  {content: '3', node_id: 3, left: 4, right: 5, parent: 0},
  {content: '4', node_id: 4, left: nil, right: nil, parent: 3},
  {content: '5', node_id: 5, left: 6, right: nil, parent: 3},
  {content: '6', node_id: 6, left: nil, right: nil, parent: 5}
]
Node.all.destroy_all

initial_nodes.each do |n|
  Node.create(n)
end
