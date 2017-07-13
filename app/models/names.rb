class Names < ApplicationRecord
  @@names = Names.order(:name)
  @@tree = {}


  def self.names_table
    @@names
  end

  def self.add_names(names)
    added_counter = 0
    names.split(',').collect(&:strip).each do |name|
      if !@@names.exists?(name: name)
        added_counter += 1
        Names.create(name: name)
      end
    end
    if added_counter > 0
      @@tree = {}
    end
    added_counter
  end


  def self.autocomplete(prefix)
    current_node = @@tree

    prefix.each_char do |c|
      if current_node[c].nil?
        return nil
      end
      current_node = current_node[c]
    end

    words = []
    return build_results(current_node, '', words)
  end


  def self.name_tree
    @@tree
  end


  def self.build_name_tree
    @@names.each do |name|
      insert_word(@@tree, name.name)
    end

    @@tree
  end


  private


  def self.insert_word(sub_tree, word)
    if word.blank?
      return sub_tree
    end

    char = word[0]
    word[0] = ''

    if sub_tree[char].nil?
      sub_tree[char] = {}
    end

    new_node = sub_tree[char]
    sub_tree[char] = self.insert_word(new_node, word)

    return sub_tree
  end


  def self.build_results(sub_tree, current_name, results_arr)
    if results_arr.count > 10
      return results_arr
    end

    if sub_tree.blank?
      results_arr << current_name.clone
      return results_arr
    end

    sub_tree.keys.each do |k|
      current_name << k
      results_arr = build_results(sub_tree[k], current_name, results_arr)
      current_name[current_name.length-1] = ''
    end
    results_arr
  end
end
