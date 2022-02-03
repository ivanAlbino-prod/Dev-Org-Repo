trigger authorChangeTrigger on Author__ChangeEvent (after insert) {
	new AuthorChangeTriggerHandler().run();
}