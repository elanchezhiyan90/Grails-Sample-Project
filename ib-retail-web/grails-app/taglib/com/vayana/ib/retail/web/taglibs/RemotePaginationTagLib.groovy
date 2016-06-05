package com.vayana.ib.retail.web.taglibs

import org.springframework.web.servlet.support.RequestContextUtils as RCU

/**
 * This tag enables pagination on the list asynchronously.
 * @author Amit Jain (amit@intelligrape.com)
 */
class RemotePaginationTagLib {
    static namespace = "util"

    def remotePaginate = {attrs ->
        def writer = out

        if (attrs.total == null)
            throwTagError("Tag [remotePaginate] is missing required attribute [total]")

        if (attrs.update == null)
            throwTagError("Tag [remotePaginate] is missing required attribute [update]")

        if (!attrs.action)
            throwTagError("Tag [remotePaginate] is missing required attribute [action]")

        def messageSource = grailsAttributes.getApplicationContext().getBean("messageSource")
        def locale = RCU.getLocale(request)

        Integer total = attrs.total.toInteger()
        Integer offset = params.offset?.toInteger()
        Integer max = params.max?.toInteger()
        Integer maxsteps = params.maxsteps?.toInteger()
        def pageSizes = attrs.pageSizes ?: []
        Boolean alwaysShowPageSizes = new Boolean(attrs.alwaysShowPageSizes?:false)
        Map linkTagAttrs = attrs


        if (!offset) offset = (attrs.offset ? attrs.offset.toInteger() : 0)

        if (!max) max = (attrs.max ? attrs.max.toInteger() : 10)

        if (!maxsteps) maxsteps = (attrs.maxsteps ? attrs.maxsteps.toInteger() : 10)

        Map linkParams = [offset: offset - max, max: max]
        Map selectParams = [:]
        if (params.sort) linkParams.sort = params.sort
        if (params.order) linkParams.order = params.order
        if (attrs.params) {
            linkParams.putAll(attrs.params)
            selectParams.putAll(linkParams)
        }

        if (attrs.id != null) {linkTagAttrs.id = attrs.id}
        linkTagAttrs.params = linkParams

        // determine paging variables
        boolean steps = maxsteps > 0
        Integer currentstep = (offset / max) + 1
        Integer firststep = 1
        Integer laststep = Math.round(Math.ceil(total / max))

        // display previous link when not on firststep
        if (currentstep > firststep) {
            linkTagAttrs.class = 'prevLink'
            linkParams.offset = offset - max
            writer << remoteLink(linkTagAttrs.clone()) {
                (attrs.prev ? attrs.prev : messageSource.getMessage('paginate.prev', null, messageSource.getMessage('default.paginate.prev', null, 'Previous', locale), locale))
            }
        }

        // display steps when steps are enabled and laststep is not firststep
        if (steps && laststep > firststep) {
            linkTagAttrs.class = 'step'

            // determine begin and endstep paging variables
            Integer beginstep = currentstep - Math.round(maxsteps / 2) + (maxsteps % 2)
            Integer endstep = currentstep + Math.round(maxsteps / 2) - 1

            if (beginstep < firststep) {
                beginstep = firststep
                endstep = maxsteps
            }
            if (endstep > laststep) {
                beginstep = laststep - maxsteps + 1
                if (beginstep < firststep) {
                    beginstep = firststep
                }
                endstep = laststep
            }

            // display firststep link when beginstep is not firststep
            if (beginstep > firststep) {
                linkParams.offset = 0
                writer << remoteLink(linkTagAttrs.clone()) {
                    firststep.toString()
                }
                writer << '<span class="step">..</span>'
            }

            // display paginate steps
            (beginstep..endstep).each {i ->
                if (currentstep == i) {
                    writer << "<span class=\"currentStep\">${i}</span>"
                } else {
                    linkParams.offset = (i - 1) * max
                    writer << remoteLink(linkTagAttrs.clone()) {i.toString()}
                }
            }

            // display laststep link when endstep is not laststep
            if (endstep < laststep) {
                writer << '<span class="step">..</span>'
                linkParams.offset = (laststep - 1) * max
                writer << remoteLink(linkTagAttrs.clone()) { laststep.toString() }
            }
        }
        // display next link when not on laststep
        if (currentstep < laststep) {
            linkTagAttrs.class = 'nextLink'
            linkParams.offset = offset + max
            writer << remoteLink(linkTagAttrs.clone()) {
                (attrs.next ? attrs.next : messageSource.getMessage('paginate.next', null, messageSource.getMessage('default.paginate.next', null, 'Next', locale), locale))
            }
        }

        if ((alwaysShowPageSizes || total > max) && pageSizes) {
            selectParams.remove("max")
            selectParams.offset=0
            String paramsStr = selectParams.collect {it.key + "=" + it.value}.join("&")
            paramsStr = '\'' + paramsStr + '&max=\' + this.value'
            linkTagAttrs.params = paramsStr
            Boolean isPageSizesMap = pageSizes instanceof Map

            writer << "<span>" + select(from: pageSizes, value: max, name: "max", onchange: "${remoteFunction(linkTagAttrs.clone())}" ,class: 'remotepagesizes',
                    optionKey: isPageSizesMap?'key':'', optionValue: isPageSizesMap?'value':'') + "</span>"
        }
    }

    /**
     * This tag enables sort in an ascending/descending order on the particular attribute of an object, asynchronously.
     * @author Amit Jain (amit@intelligrape.com)
     */
    def remoteSortableColumn = {attrs ->
        def writer = out
        if (!attrs.property)
            throwTagError("Tag [remoteSortableColumn] is missing required attribute [property]")

        if (!attrs.title && !attrs.titleKey)
            throwTagError("Tag [remoteSortableColumn] is missing required attribute [title] or [titleKey]")

        if (!attrs.update)
            throwTagError("Tag [remoteSortableColumn] is missing required attribute [update]")

        if (!attrs.action)
            throwTagError("Tag [remoteSortableColumn] is missing required attribute [action]")

        def property = attrs.remove("property")
        String defaultOrder = attrs.remove("defaultOrder")
        if (defaultOrder != "desc") defaultOrder = "asc"
        Map linkTagAttrs = attrs

        // current sorting property and order
        String sort = params.sort
        String order = params.order

        // add sorting property and params to link params
        Map linkParams = [:]
        if (params.id) linkParams.put("id", params.id)
        if (attrs.params) linkParams.putAll(attrs.remove("params"))
        linkParams.sort = property

        // determine and add sorting order for this column to link params
        attrs.class = (attrs.class ? "${attrs.class} sortable" : "sortable")
        if (property == sort) {
            attrs.class = attrs.class + " sorted " + order
            if (order == "asc") {
                linkParams.order = "desc"
            } else {
                linkParams.order = "asc"
            }
        } else {
            linkParams.order = defaultOrder
        }

        // determine column title
        def title = attrs.remove("title")
        def titleKey = attrs.remove("titleKey")
        if (titleKey) {
            if (!title) title = titleKey
            def messageSource = grailsAttributes.getApplicationContext().getBean("messageSource")
            def locale = RCU.getLocale(request)
            title = messageSource.getMessage(titleKey, null, title, locale)
        }

        linkTagAttrs.params = linkParams
        writer << "<th "
        // process remaining attributes
        attrs.each {k, v ->
            writer << "${k}=\"${v.encodeAsHTML()}\" "
        }
        writer << """>${remoteLink(linkTagAttrs.clone()) { title } }
                </th>"""
    }

    /**
     * This tag enables pagination asynchronously, but unlike remotePaginate it appends latest records to the existing list.
     * Important : This tag currently works only if grails views javascript library uses jQuery.
     * @author Amit Jain (amit@intelligrape.com)
     */
    def remotePageScroll = {attrs ->
        def writer = out

        if (attrs.total == null)
            throwTagError("Tag [moreRecords] is missing required attribute [total]")

        if (attrs.update == null)
            throwTagError("Tag [moreRecords] is missing required attribute [update]")

        if (!attrs.action)
            throwTagError("Tag [moreRecords] is missing required attribute [action]")

        def messageSource = grailsAttributes.getApplicationContext().getBean("messageSource")
        def locale = RCU.getLocale(request)

        Integer total = attrs.total.toInteger()
        Integer offset = params.offset?.toInteger()
        Integer max = params.max?.toInteger()
        String title = attrs.title?:'Show more...'

        if (!offset) offset = (attrs.offset ? attrs.offset.toInteger() : 0)

        if (!max) max = (attrs.max ? attrs.max.toInteger() : 10)

        Map linkParams = [offset: offset - max, max: max]
        Map selectParams = [:]
        if (params.sort) linkParams.sort = params.sort
        if (params.order) linkParams.order = params.order
        if (attrs.params) {
            linkParams.putAll(attrs.params)
            selectParams.putAll(linkParams)
        }

        String moreIdPrefix = "more" + attrs.update
        String moreDivId = moreIdPrefix + offset

        Map linkTagAttrs = attrs

        if (attrs.id != null) {linkTagAttrs.id = attrs.id}
        linkTagAttrs.params = linkParams

        if (offset + max < total) {
            linkTagAttrs.class = "moreLink"
            linkParams.offset = offset + max

            out << "<div id='${moreDivId}' class='paginateButtons'>"
            String linkHtml = remoteLink(linkTagAttrs.clone()) {
                (attrs.title ? attrs.title : messageSource.getMessage('paginate.more.title', null, messageSource.getMessage('default.paginate.more.title', null, title, locale), locale))
            }
            linkHtml =linkHtml.replace("jQuery('#${attrs.update}').html(data);", "jQuery('#${moreDivId}').remove();jQuery('#${attrs.update}').append(data);")
            out << linkHtml
            out << '</div>'
        }
    }
}
