package org.semanticwb.process.model.base;


public abstract class SignalStartEventBase extends org.semanticwb.process.model.StartEventNode implements org.semanticwb.model.Sortable,org.semanticwb.model.Traceable,org.semanticwb.process.model.BPMNSerializable,org.semanticwb.process.model.ActionCodeable,org.semanticwb.model.Descriptiveable
{
    public static final org.semanticwb.platform.SemanticClass swp_SignalStartEvent=org.semanticwb.SWBPlatform.getSemanticMgr().getVocabulary().getSemanticClass("http://www.semanticwebbuilder.org/swb4/process#SignalStartEvent");
   /**
   * The semantic class that represents the currentObject
   */
    public static final org.semanticwb.platform.SemanticClass sclass=org.semanticwb.SWBPlatform.getSemanticMgr().getVocabulary().getSemanticClass("http://www.semanticwebbuilder.org/swb4/process#SignalStartEvent");

    public static class ClassMgr
    {
       /**
       * Returns a list of SignalStartEvent for a model
       * @param model Model to find
       * @return Iterator of org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEvents(org.semanticwb.model.SWBModel model)
        {
            java.util.Iterator it=model.getSemanticObject().getModel().listInstancesOfClass(sclass);
            return new org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent>(it, true);
        }
       /**
       * Returns a list of org.semanticwb.process.model.SignalStartEvent for all models
       * @return Iterator of org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEvents()
        {
            java.util.Iterator it=sclass.listInstances();
            return new org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent>(it, true);
        }

        public static org.semanticwb.process.model.SignalStartEvent createSignalStartEvent(org.semanticwb.model.SWBModel model)
        {
            long id=model.getSemanticObject().getModel().getCounter(sclass);
            return org.semanticwb.process.model.SignalStartEvent.ClassMgr.createSignalStartEvent(String.valueOf(id), model);
        }
       /**
       * Gets a org.semanticwb.process.model.SignalStartEvent
       * @param id Identifier for org.semanticwb.process.model.SignalStartEvent
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return A org.semanticwb.process.model.SignalStartEvent
       */
        public static org.semanticwb.process.model.SignalStartEvent getSignalStartEvent(String id, org.semanticwb.model.SWBModel model)
        {
            return (org.semanticwb.process.model.SignalStartEvent)model.getSemanticObject().getModel().getGenericObject(model.getSemanticObject().getModel().getObjectUri(id,sclass),sclass);
        }
       /**
       * Create a org.semanticwb.process.model.SignalStartEvent
       * @param id Identifier for org.semanticwb.process.model.SignalStartEvent
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return A org.semanticwb.process.model.SignalStartEvent
       */
        public static org.semanticwb.process.model.SignalStartEvent createSignalStartEvent(String id, org.semanticwb.model.SWBModel model)
        {
            return (org.semanticwb.process.model.SignalStartEvent)model.getSemanticObject().getModel().createGenericObject(model.getSemanticObject().getModel().getObjectUri(id,sclass),sclass);
        }
       /**
       * Remove a org.semanticwb.process.model.SignalStartEvent
       * @param id Identifier for org.semanticwb.process.model.SignalStartEvent
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       */
        public static void removeSignalStartEvent(String id, org.semanticwb.model.SWBModel model)
        {
            model.getSemanticObject().getModel().removeSemanticObject(model.getSemanticObject().getModel().getObjectUri(id,sclass));
        }
       /**
       * Returns true if exists a org.semanticwb.process.model.SignalStartEvent
       * @param id Identifier for org.semanticwb.process.model.SignalStartEvent
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return true if the org.semanticwb.process.model.SignalStartEvent exists, false otherwise
       */

        public static boolean hasSignalStartEvent(String id, org.semanticwb.model.SWBModel model)
        {
            return (getSignalStartEvent(id, model)!=null);
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Next
       * @param value Next of the type org.semanticwb.process.model.FlowNode
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByNext(org.semanticwb.process.model.FlowNode value,org.semanticwb.model.SWBModel model)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(model.getSemanticObject().getModel().listSubjectsByClass(swp_ie_next, value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Next
       * @param value Next of the type org.semanticwb.process.model.FlowNode
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByNext(org.semanticwb.process.model.FlowNode value)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(value.getSemanticObject().getModel().listSubjectsByClass(swp_ie_next,value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Container
       * @param value Container of the type org.semanticwb.process.model.Containerable
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByContainer(org.semanticwb.process.model.Containerable value,org.semanticwb.model.SWBModel model)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(model.getSemanticObject().getModel().listSubjectsByClass(swp_container, value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Container
       * @param value Container of the type org.semanticwb.process.model.Containerable
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByContainer(org.semanticwb.process.model.Containerable value)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(value.getSemanticObject().getModel().listSubjectsByClass(swp_container,value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Parent
       * @param value Parent of the type org.semanticwb.process.model.GraphicalElement
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByParent(org.semanticwb.process.model.GraphicalElement value,org.semanticwb.model.SWBModel model)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(model.getSemanticObject().getModel().listSubjectsByClass(swp_parent, value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Parent
       * @param value Parent of the type org.semanticwb.process.model.GraphicalElement
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByParent(org.semanticwb.process.model.GraphicalElement value)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(value.getSemanticObject().getModel().listSubjectsByClass(swp_parent,value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Documentation
       * @param value Documentation of the type org.semanticwb.process.model.Documentation
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByDocumentation(org.semanticwb.process.model.Documentation value,org.semanticwb.model.SWBModel model)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(model.getSemanticObject().getModel().listSubjectsByClass(swp_hasDocumentation, value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Documentation
       * @param value Documentation of the type org.semanticwb.process.model.Documentation
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByDocumentation(org.semanticwb.process.model.Documentation value)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(value.getSemanticObject().getModel().listSubjectsByClass(swp_hasDocumentation,value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined OutputConnectionObject
       * @param value OutputConnectionObject of the type org.semanticwb.process.model.ConnectionObject
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByOutputConnectionObject(org.semanticwb.process.model.ConnectionObject value,org.semanticwb.model.SWBModel model)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(model.getSemanticObject().getModel().listSubjectsByClass(swp_hasOutputConnectionObjectInv, value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined OutputConnectionObject
       * @param value OutputConnectionObject of the type org.semanticwb.process.model.ConnectionObject
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByOutputConnectionObject(org.semanticwb.process.model.ConnectionObject value)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(value.getSemanticObject().getModel().listSubjectsByClass(swp_hasOutputConnectionObjectInv,value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined FlowObjectInstance
       * @param value FlowObjectInstance of the type org.semanticwb.process.model.FlowNodeInstance
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByFlowObjectInstance(org.semanticwb.process.model.FlowNodeInstance value,org.semanticwb.model.SWBModel model)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(model.getSemanticObject().getModel().listSubjectsByClass(swp_hasFlowNodeInstanceInv, value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined FlowObjectInstance
       * @param value FlowObjectInstance of the type org.semanticwb.process.model.FlowNodeInstance
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByFlowObjectInstance(org.semanticwb.process.model.FlowNodeInstance value)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(value.getSemanticObject().getModel().listSubjectsByClass(swp_hasFlowNodeInstanceInv,value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Child
       * @param value Child of the type org.semanticwb.process.model.GraphicalElement
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByChild(org.semanticwb.process.model.GraphicalElement value,org.semanticwb.model.SWBModel model)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(model.getSemanticObject().getModel().listSubjectsByClass(swp_hasChildInv, value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Child
       * @param value Child of the type org.semanticwb.process.model.GraphicalElement
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByChild(org.semanticwb.process.model.GraphicalElement value)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(value.getSemanticObject().getModel().listSubjectsByClass(swp_hasChildInv,value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined ModifiedBy
       * @param value ModifiedBy of the type org.semanticwb.model.User
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByModifiedBy(org.semanticwb.model.User value,org.semanticwb.model.SWBModel model)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(model.getSemanticObject().getModel().listSubjectsByClass(swb_modifiedBy, value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined ModifiedBy
       * @param value ModifiedBy of the type org.semanticwb.model.User
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByModifiedBy(org.semanticwb.model.User value)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(value.getSemanticObject().getModel().listSubjectsByClass(swb_modifiedBy,value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Creator
       * @param value Creator of the type org.semanticwb.model.User
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByCreator(org.semanticwb.model.User value,org.semanticwb.model.SWBModel model)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(model.getSemanticObject().getModel().listSubjectsByClass(swb_creator, value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined Creator
       * @param value Creator of the type org.semanticwb.model.User
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByCreator(org.semanticwb.model.User value)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(value.getSemanticObject().getModel().listSubjectsByClass(swb_creator,value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined InputConnectionObject
       * @param value InputConnectionObject of the type org.semanticwb.process.model.ConnectionObject
       * @param model Model of the org.semanticwb.process.model.SignalStartEvent
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByInputConnectionObject(org.semanticwb.process.model.ConnectionObject value,org.semanticwb.model.SWBModel model)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(model.getSemanticObject().getModel().listSubjectsByClass(swp_hasInputConnectionObjectInv, value.getSemanticObject(),sclass));
            return it;
        }
       /**
       * Gets all org.semanticwb.process.model.SignalStartEvent with a determined InputConnectionObject
       * @param value InputConnectionObject of the type org.semanticwb.process.model.ConnectionObject
       * @return Iterator with all the org.semanticwb.process.model.SignalStartEvent
       */

        public static java.util.Iterator<org.semanticwb.process.model.SignalStartEvent> listSignalStartEventByInputConnectionObject(org.semanticwb.process.model.ConnectionObject value)
        {
            org.semanticwb.model.GenericIterator<org.semanticwb.process.model.SignalStartEvent> it=new org.semanticwb.model.GenericIterator(value.getSemanticObject().getModel().listSubjectsByClass(swp_hasInputConnectionObjectInv,value.getSemanticObject(),sclass));
            return it;
        }
    }

    public static SignalStartEventBase.ClassMgr getSignalStartEventClassMgr()
    {
        return new SignalStartEventBase.ClassMgr();
    }

   /**
   * Constructs a SignalStartEventBase with a SemanticObject
   * @param base The SemanticObject with the properties for the SignalStartEvent
   */
    public SignalStartEventBase(org.semanticwb.platform.SemanticObject base)
    {
        super(base);
    }

/**
* Gets the ActionCode property
* @return String with the ActionCode
*/
    public String getActionCode()
    {
        return getSemanticObject().getProperty(swp_actionCode);
    }

/**
* Sets the ActionCode property
* @param value long with the ActionCode
*/
    public void setActionCode(String value)
    {
        getSemanticObject().setProperty(swp_actionCode, value);
    }

   /**
   * Gets the ProcessSite
   * @return a instance of org.semanticwb.process.model.ProcessSite
   */
    public org.semanticwb.process.model.ProcessSite getProcessSite()
    {
        return (org.semanticwb.process.model.ProcessSite)getSemanticObject().getModel().getModelObject().createGenericInstance();
    }
}
