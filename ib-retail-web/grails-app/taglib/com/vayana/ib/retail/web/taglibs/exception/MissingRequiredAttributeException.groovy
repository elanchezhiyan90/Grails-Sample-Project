package com.vayana.ib.retail.web.taglibs.exception

class MissingRequiredAttributeException extends RuntimeException {

    MissingRequiredAttributeException(String attribute) {
        super(String.format("Required attribute %s is missing.", attribute))
    }

}
