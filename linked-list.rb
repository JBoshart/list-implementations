# Quick Example of a Self Referential Data Structure in Ruby
# NODE -> contains a value and a pointer to (next_node)
# LinkedList -> This class holds the linked list functions - adding a node, traversing and displaying the linked list

class Node
 attr_accessor :value, :next_node

 def initialize(val,next_in_line=nil)
   @value = val
   @next_node = next_in_line
   puts "Initialized a Node with value:  " + val.to_s
 end
end

class LinkedList
#In a LinkedList each node only knows what the node in front of it is, it does not know what the node behind it was, or what the last node is. It only knows about the next node.
 def initialize(val)
  # Initialize a new node at the head
  @head = Node.new(val,nil)
 end

 def add(value)
  # Traverse to the end of the list
  # And insert a new node over there with the specified value
  current = @head
  while current.next_node != nil
    current = current.next_node
  end
  current.next_node = Node.new(value,nil)
  self
 end

 def delete(val)
  current = @head
  if current.value == val
    # If the head is the element to be delete, the head needs to be updated
    @head = @head.next_node
  else
    # ... x -> y -> z
    # Suppose y is the value to be deleted, you need to reshape the above list to :
    #   ... x->z
    # ( and z is basically y.next_node )
    current = @head
      while (current != nil) && (current.next_node != nil) && ((current.next_node).value != val)
        current = current.next_node
      end

      if (current != nil) && (current.next_node != nil)
        current.next_node = (current.next_node).next_node
      end
    end
  end

 def display
  # Traverse through the list till you hit the "nil" at the end
  current = @head
  full_list = []
  while current.next_node != nil
    full_list += [current.value.to_s]
    current = current.next_node
  end
  full_list += [current.value.to_s]
  puts full_list.join("->")
 end

 def include?(key)
   current = @head
   while current != nil
     if current.value != key
       current = current.next_node
     elsif current.value == key
       puts "true"
       return true
     else
       puts "false"
       return false
     end
   end
 end

 def size
   count = 1
   current = @head
   while current.next_node != nil
     count += 1
     current = current.next_node
   end
   return count
 end

 def max
   max = 0
   current = @head
   while current != nil
     if current.value > max
       max = current.value
     end
     current = current.next_node
   end
   return max
 end
end

# Initializing a Linked List with a node containing value (5)
ll = LinkedList.new(5)

# Adding Elements to Linked List
ll.add(10)
ll.add(20)

# Display the Linked List
puts "Displaying Linked List:"
ll.display

puts "Delete 10 and then display the linked list:"
ll.delete(10)
ll.display

# Find element in list:
puts "Is 20 in the list?"
"#{ll.include?(20)}"

# Give the size of the list:
puts "The size of the list is #{ll.size}."

#Find the highest value in the list:
puts "The highest value in the list is #{ll.max}."

=begin
Output:
Initialized a Node with value:  5
Initialized a Node with value:  10
Initialized a Node with value:  20
Displaying Linked List:
5->10->20
Delete 10 and then display the linked list:
5->20
Is 20 in the list?
true
The size of the list is 2.
The highest value in the list is 20.
=end
