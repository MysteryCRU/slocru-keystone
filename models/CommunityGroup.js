var keystone = require('keystone');
var Types = keystone.Field.Types;

/**
 * CommunityGroup Model
 * ==========
 */

//TODO this model is crap, missing tons of info. Come back to it later

var CommunityGroup = new keystone.List('CommunityGroup', {
	map: { name: 'name' },
	autokey: { path: 'slug', from: 'leaders', unique: true }
});

CommunityGroup.add({
	name: { type: String, required: true, initial: true },
    description: { type: String, initial: true },
	meetingTime: { type: Types.Datetime, initial: true },
    leaders: { type: Types.Relationship, ref: 'User', many: true },
	parentMinistry: { type: Types.Relationship, ref: 'Ministry', initial: true }
});

CommunityGroup.relationship({ path: 'answers', ref: 'MinistryQuestionAnswer', refPath: 'ministry'});

CommunityGroup.defaultColumns = 'name, leaders';
CommunityGroup.register();
