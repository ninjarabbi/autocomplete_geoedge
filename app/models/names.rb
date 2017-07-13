class Names < ApplicationRecord
  @@names = Names.order(:name)
  @@tree = {}


  def self.autocomplete(prefix)
    current = @@tree

    prefix.each_char do |c|
      if current[c].nil?
        return nil
      end
      current = current[c]
    end

    words = []
    return build_results(current, '', words)
  end


  def self.name_tree
    @@tree
  end


  def self.print_tree
    pp @@tree
  end


  def self.build_name_tree
    @@names.each do |name|
      insert_word(@@tree, name.name)
    end

    @@tree
  end


  private


  def self.insert_word(sub_tree, word)
    # pp "#{sub_tree}, #{word}"
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
