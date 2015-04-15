To build the gem .... 

- Find a valid version of extjs 4.1.1a, unzip and put it in template/extjs
- Open Rakefile and comment lines 108 to 119 in the function compress 
- rake config_file
- rake gem

if an error occurs "can't modify frozen array", 
add the following line in template/extjs/themes/lib/utils at line 17
    new_list = list.to_a.map {|a| a} if new_list.frozen?

- finally, 'gem install xxx.gem' will do the job



