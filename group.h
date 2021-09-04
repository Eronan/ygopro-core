/*
 * group.h
 *
 *  Created on: 2010-5-6
 *      Author: Argon
 */

#ifndef GROUP_H_
#define GROUP_H_

#include "common.h"
#include "lua_obj.h"
#include <algorithm>
#include <set>
#include <list>
#include <vector>

class card;
class duel;

class group : public lua_obj_helper<PARAM_TYPE_GROUP> {
public:
	typedef std::set<card*, card_sort> card_set;
	card_set container;
	card_set::iterator it;
	uint32 is_readonly{ 0 };
	
	inline bool has_card(card* c) const {
		return container.find(c) != container.end();
	}
	
	explicit group(duel* pd) : lua_obj_helper(pd) {};
	group(duel* pd, card* pcard) : lua_obj_helper(pd), container({ pcard }) {};
	group(duel* pd, const card_set& cset) : lua_obj_helper(pd), container(cset) {};
	group(duel* pd, card_set&& cset) : lua_obj_helper(pd), container(std::move(cset)) {};
	group(duel* pd, group* pgroup) : lua_obj_helper(pd), container(pgroup->container) {};
	group(duel* pd, const std::vector<card*>& vcard) : lua_obj_helper(pd), container(vcard.begin(), vcard.end()) {};
	group(duel* pd, lua_obj* pobj);
	~group() = default;
};

#endif /* GROUP_H_ */
