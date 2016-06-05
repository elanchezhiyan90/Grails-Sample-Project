package com.vayana.ib.retail.web.taglibs.exception

class UnknownAttributeException extends RuntimeException {

    UnknownAttributeException(String attribute) {

        super(String.format("Unknown attribute %s", attribute))
    }

}
