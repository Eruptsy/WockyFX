module wockyfx

pub fn char_count(str string, cha string) int {
	mut char_count := 0
	for i, ch in str {
		c := ch.ascii_str()
		if c == cha {
			char_count++
		} 
	}
	return char_count
}

pub fn get_str_between(t string, start string, end string) string {
	mut new_str := ""
	mut ignore := true // ignore current text
	for i, letter in t {
		c := letter.ascii_str()
		if c == start && ignore == true {
			ignore = false
		} else if c == end && ignore == false {
			return new_str
		} else if ignore == false {
			new_str += c
		}
	}
	return new_str //, t.replace(new_str, "")
}

