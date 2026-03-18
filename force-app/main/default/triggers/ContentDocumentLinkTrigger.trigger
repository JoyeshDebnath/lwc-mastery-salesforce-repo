trigger ContentDocumentLinkTrigger on ContentDocumentLink (after insert) {
    ContentDocumentLinkTriggerDispatcher.dispatch(Trigger.OperationType);
}