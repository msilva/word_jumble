require 'set'

class PermutationUtil
  @@permutations = Set.new
  @@wordFile = []

  def initialize
    load_word_file
  end


  def load_word_file
    default_dict_file = File.join(File.dirname(__FILE__), 'dict/en_US.dic')
    File.readlines(default_dict_file).each do |line|
      #ruleIndex = line.index("/")
      #if line.index("/")
      #  line = line[0, ruleIndex]
      #end
      @@wordFile << line.chomp.downcase
    end
  end

  def show_word_list
    @@wordFile.each {|w| puts w }
  end

  def word_list_size
    @@wordFile.size
  end

  def show_permutations
    @@permutations.each {|w| puts w }
  end

  def permutations_size
    @@permutations.size
  end


  def self.subsets(str="")
    subsets = Set.new
    n = str.length
    num_subsets = 2**n - 2
    subsets.add(str)
    1.upto(num_subsets) do |subset_int|
      subset = ""
      for j in 0...n
        unless subset_int[j].zero?
          subset.prepend str[j]
        end
      end
      subsets.add(subset)
    end
    subsets
  end

  def permutation(wordJumble)
    return [wordJumble] if wordJumble.size < 2
    ch = wordJumble[0]
    jum = wordJumble[1..-1]
    permutation(jum).each_with_object([]) do |perm, result|
      (0..perm.size).each { |i| result << perm.dup.insert(i,ch) }
    end
  end

  def permutation_and_subset(wordJumble)
    wordJumble = wordJumble.downcase
    set = Set.new
    PermutationUtil.subsets(wordJumble).each do |sub|
      permutation(sub).each do |perm|
        set.add(perm)
      end
    end
    set
  end

  def lookupWord(wordJumble)
    wordJumble = wordJumble.downcase
    if @@permutations.include?(wordJumble)
      return
    end
    #puts "Looking up " + wordJumble


    if(@@wordFile.include?(wordJumble))
      #puts "Adding " + wordJumble
      @@permutations.add(wordJumble)

    end
  end

end

#u = PermutationUtil.new
#u.show_word_list
#puts "Permutations Size: " + u.permutations_size.to_s
#permAndSubset = u.permutation_and_subset("dog")
#puts "permAndSubset Size: " + permAndSubset.size.to_s
#permAndSubset.each {|n| puts n}


#permAndSubset.each {|d| u.lookupWord(d)}
#u.show_permutations
#puts "Permutations Size: " + u.permutations_size.to_s
