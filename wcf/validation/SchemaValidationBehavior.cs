namespace Util.WCF.Validation
{
	public class SchemaValidationBehavior : IEndpointBehavior  
	{  
		XmlSchemaSet schemaSet;
		bool validateRequest;
		bool validateReply;  
	  
		public SchemaValidationBehavior(XmlSchemaSet schemaSet, bool
							   inspectRequest, bool inspectReply)  
		{  
			this.schemaSet = schemaSet;  
			this.validateReply = inspectReply;  
			this.validateRequest = inspectRequest;  
		}  
	  
		public void AddBindingParameters(ServiceEndpoint endpoint,
		   System.ServiceModel.Channels.BindingParameterCollection
												bindingParameters)  
		{  
		}  
	  
		public void ApplyClientBehavior(ServiceEndpoint endpoint,
				System.ServiceModel.Dispatcher.ClientRuntime clientRuntime)  
		{  
			SchemaValidationMessageInspector inspector =
			   new SchemaValidationMessageInspector(schemaSet,
						  validateRequest, validateReply, true);  
				clientRuntime.MessageInspectors.Add(inspector);  
		}  
	  
		public void ApplyDispatchBehavior(ServiceEndpoint endpoint,
			 System.ServiceModel.Dispatcher.EndpointDispatcher
											  endpointDispatcher)  
		{  
			SchemaValidationMessageInspector inspector =
			   new SchemaValidationMessageInspector(schemaSet,
							validateRequest, validateReply, false);  
	   endpointDispatcher.DispatchRuntime.MessageInspectors.Add(inspector);  
		}  
	  
	   public void Validate(ServiceEndpoint endpoint)  
	   {  
	   }  
	}
}