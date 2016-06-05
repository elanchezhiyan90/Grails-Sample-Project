function chr(a) {
    if (a > 0xFFFF) {
        a -= 0x10000;
        return String.fromCharCode(0xD800 + (a >> 10), 0xDC00 + (a & 0x3FF))
    } else {
        return String.fromCharCode(a)
    }
}
function implode(a, b) {
    var i = '',
        retVal = '',
        tGlue = '';
    if (arguments.length === 1) {
        b = a;
        a = ''
    }
    if (typeof (b) === 'object') {
        if (b instanceof Array) {
            return b.join(a)
        } else {
            for (i in b) {
                retVal += tGlue + b[i];
                tGlue = a
            }
            return retVal
        }
    } else {
        return b
    }
}
function join(a, b) {
    return this.implode(a, b)
}
function ord(a) {
    var b = a + '';
    var c = b.charCodeAt(0);
    if (0xD800 <= c && c <= 0xDBFF) {
        var d = c;
        if (b.length === 1) {
            return c
        }
        var e = b.charCodeAt(1);
        if (!e) {}
        return ((d - 0xD800) * 0x400) + (e - 0xDC00) + 0x10000
    }
    if (0xDC00 <= c && c <= 0xDFFF) {
        return c
    }
    return c
}
function str_pad(c, d, e, f) {
    var g = '',
        pad_to_go;
    var h = function (s, a) {
        var b = '',
            i;
        while (b.length < a) {
            b += s
        }
        b = b.substr(0, a);
        return b
    };
    c += '';
    e = e !== undefined ? e : ' ';
    if (f != 'STR_PAD_LEFT' && f != 'STR_PAD_RIGHT' && f != 'STR_PAD_BOTH') {
        f = 'STR_PAD_RIGHT'
    }
    if ((pad_to_go = d - c.length) > 0) {
        if (f == 'STR_PAD_LEFT') {
            c = h(e, pad_to_go) + c
        } else if (f == 'STR_PAD_RIGHT') {
            c = c + h(e, pad_to_go)
        } else if (f == 'STR_PAD_BOTH') {
            g = h(e, Math.ceil(pad_to_go / 2));
            c = g + c + g;
            c = c.substr(0, d)
        }
    }
    return c
}
function str_split(a, b) {
    if (a === undefined || !a.toString || b < 1) {
        return false
    }
    return a.toString()
        .match(new RegExp('.{1,' + (b || '1') + '}', 'g'))
}
function strlen(d) {
    var e = d + '';
    var i = 0,
        chr = '',
        lgth = 0;
    var f = function (a, i) {
        var b = a.charCodeAt(i);
        var c = '',
            prev = '';
        if (0xD800 <= b && b <= 0xDBFF) {
            if (a.length <= (i + 1)) {
                throw 'High surrogate without following low surrogate';
            }
            c = a.charCodeAt(i + 1);
            if (0xDC00 > c || c > 0xDFFF) {
                throw 'High surrogate without following low surrogate';
            }
            return a.charAt(i) + a.charAt(i + 1)
        } else if (0xDC00 <= b && b <= 0xDFFF) {
            if (i === 0) {
                throw 'Low surrogate without preceding high surrogate';
            }
            prev = a.charCodeAt(i - 1);
            if (0xD800 > prev || prev > 0xDBFF) {
                throw 'Low surrogate without preceding high surrogate';
            }
            return false
        }
        return a.charAt(i)
    };
    for (i = 0, lgth = 0; i < e.length; i++) {
        if ((chr = f(e, i)) === false) {
            continue
        }
        lgth++
    }
    return lgth
}

function c2sencrypt(s,k){
				k = str_split(str_pad('',strlen(s),k));
				sa = str_split(s);
				for(var i in sa){
					t = ord(sa[i])+ord(k[i]);
					sa[i] = chr(t > 255 ?(t-256):t);
				}
				return escape(join('', sa));
}
function randomString() {
    var a = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz!@#$%^&*()";
    var b = 8;
    var c = '';
    for (var i = 0; i < b; i++) {
        var d = Math.floor(Math.random() * a.length);
        c += a.substring(d, d + 1)
    }
    return c
}
jQuery.fn.encypform = function(){
	
	var form=$(this);
	var key = '12345';// key can be dynamic
	
	form.after("<div id='new_form_content' style='display:none'></div>")
		
	var updateIds = function (form) {
	  form.find("select,input[type='text'],input[type='number']").each(function (index, element) {
		if ($(element).attr("id")) {
		  $(element).attr("id", "new_" + $(element).attr("id"));
		}
	  });
	};

	var encryptFormValues = function () {
	  $("select,input[type='text'],input[type='number']").each(function (index, element) {
		var elementId = $(element).attr("id");
		var e = c2sencrypt($(element).val(), key);

			if( $("#new_" + elementId).is("select")){
				$("#new_" + elementId).find("option:selected").val(e)
			}
			if( $("#new_" + elementId).is("input[type='text']")){
				$("#new_" + elementId).val(e);
			}
			if( $("#new_" + elementId).is("input[type='number']")){
				$("#new_" + elementId).get(0).type='text';
				$("#new_" + elementId).val(e);
			}
		
	  });
	};

	var encryptedForm = function () {
	  var newForm = form.clone();
	  updateIds(newForm);
	  $('#new_form_content').append(newForm);
	  encryptFormValues();
	 
	};

	form.submit(function (event) {
		event.preventDefault();
	  	encryptedForm();
	 	$('#new_form_content').find("form").submit();
	  return false;
	});

}