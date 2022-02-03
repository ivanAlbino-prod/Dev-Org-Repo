trigger bookChangeTrigger on Book__ChangeEvent (after insert) {
	new BookChangeTriggerHandler().run();
}