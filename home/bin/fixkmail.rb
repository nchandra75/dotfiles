#!/usr/bin/ruby
# Script to convert Maildir folders to kmail structure ( ".folder.directory" )
# Nitin -- Feb 5 04

mailroot = "Mail"
# Look inside mailroot, anything that is not cur, new, tmp must be processed
# How? Depth first in, and then move to parent with new name.

# Recursive function to do the DFS
def traverse (dir, 
	parent='', 
  	exc=["cur","new","tmp"], 
	func=proc {|d| puts d})
  # Get the list of files in the dir, remove all non-dirs and cur,new,tmp
  Dir.chdir(dir) rescue raise "Bad or non-existent root dir #{dir}"
  dirs = Dir.glob("*")
  dirs.delete_if { |f|
    exc.member?(f) or ! File.directory?(f)
  }

  if ! dirs.empty?
    dirs.each { |d|
      traverse (d,dir,exc,func) 
      func.call(d,dir)
    }
  end
  Dir.chdir("..") rescue raise "Could not return!"
end

movedir = proc {|d, parent|
  if ! parent.empty?
    a = "../.#{parent}.directory"
    puts "#{a}/#{d}"
    if (! File.exists?(a)) 
      Dir.mkdir(a)
    end
    File.rename(d,"#{a}/#{d}")
  end
}


traverse(ARGV[0],'',["cur","new","tmp"], movedir)

