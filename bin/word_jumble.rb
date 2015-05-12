require 'set'
require_relative 'permutation_util'



  word = (ARGV.shift || "dog")

  u = PermutationUtil.new
  permAndSubset = u.permutation_and_subset("dog")
  permAndSubset.each {|d| u.lookupWord(d)}
  u.show_permutations
