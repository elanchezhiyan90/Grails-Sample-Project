package com.vayana.ib.retail.web.constraint
import org.codehaus.groovy.grails.validation.AbstractConstraint
import org.springframework.validation.Errors;
import com.vayana.ib.bm.core.impl.service.util.iban.Iban;
import org.springframework.util.StringUtils;
import com.vayana.ib.bm.core.impl.service.util.iban.IbanFormatException

class IBANConstraint extends AbstractConstraint{
	
	public static final String CONSTRAINT_NAME = "iban"
	
	@Override
	public boolean supports(Class type) {
		return type && String.class.isAssignableFrom(type);
	}

	@Override
	public String getName() {
		return CONSTRAINT_NAME;
	}
	
	@Override
	protected void processValidate(Object target, Object propertyValue,Errors errors) 
	{
		if(StringUtils.hasLength(propertyValue))
		{
			String ibanString = propertyValue.toString();
			try
			{
				Iban iban = new Iban(ibanString);
				if(iban!=null)
				{
					// Iban is valid
				}
			}
			catch(IbanFormatException ibanExp)
			{
				target.errors.rejectValue('iban','iban.validate.error');
			}
			
		}
		
	}
}
