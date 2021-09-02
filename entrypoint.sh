#!/bin/sh -l

branch_name=$1

ruby -rspicy-proton -rdigest/sha1 -e'
  branch_name_hash = Digest::SHA1.hexdigest("${branch_name}").to_i(16)
  words            = Spicy::Proton.new
  adjective        = words.adjectives[branch_name_hash % words.adjectives.length]
  noun             = words.nouns[branch_name_hash % words.nouns.length]
  puts "#{adjective}-#{noun}"
'