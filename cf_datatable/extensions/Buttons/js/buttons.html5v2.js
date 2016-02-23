(function(g) {
    "function" === typeof define && define.amd ? define(["jquery", "datatables.net", "datatables.net-buttons"], function(d) {
        return g(d, window, document)
    }) : "object" === typeof exports ? module.exports = function(d, f) {
        d || (d = window);
        if (!f || !f.fn.dataTable) f = require("datatables.net")(d, f).$;
        f.fn.dataTable.Buttons || require("datatables.net-buttons")(d, f);
        return g(f, d, d.document)
    } : g(jQuery, window, document)
})(function(g, d, f, k) {
    var l = g.fn.dataTable,
        j;
    if ("undefined" !== typeof navigator && /MSIE [1-9]\./.test(navigator.userAgent)) j =
        void 0;
    else {
        var v = d.document,
            o = v.createElementNS("http://www.w3.org/1999/xhtml", "a"),
            D = "download" in o,
            p = d.webkitRequestFileSystem,
            w = d.requestFileSystem || p || d.mozRequestFileSystem,
            E = function(a) {
                (d.setImmediate || d.setTimeout)(function() {
                    throw a;
                }, 0)
            },
            q = 0,
            r = function(a) {
                var b = function() {
                    "string" === typeof a ? (d.URL || d.webkitURL || d).revokeObjectURL(a) : a.remove()
                };
                d.chrome ? b() : setTimeout(b, 500)
            },
            s = function(a, b, e) {
                for (var b = [].concat(b), c = b.length; c--;) {
                    var d = a["on" + b[c]];
                    if ("function" === typeof d) try {
                        d.call(a,
                            e || a)
                    } catch (h) {
                        E(h)
                    }
                }
            },
            y = function(a) {
                return /^\s*(?:text\/\S*|application\/xml|\S*\/\S*\+xml)\s*;.*charset\s*=\s*utf-8/i.test(a.type) ? new Blob(["﻿", a], {
                    type: a.type
                }) : a
            },
            A = function(a, b) {
                var a = y(a),
                    e = this,
                    c = a.type,
                    x = !1,
                    h, g, z = function() {
                        s(e, ["writestart", "progress", "write", "writeend"])
                    },
                    f = function() {
                        if (x || !h) h = (d.URL || d.webkitURL || d).createObjectURL(a);
                        g ? g.location.href = h : d.open(h, "_blank") === k && "undefined" !== typeof safari && (d.location.href = h);
                        e.readyState = e.DONE;
                        z();
                        r(h)
                    },
                    n = function(a) {
                        return function() {
                            if (e.readyState !==
                                e.DONE) return a.apply(this, arguments)
                        }
                    },
                    i = {
                        create: !0,
                        exclusive: !1
                    },
                    j;
                e.readyState = e.INIT;
                b || (b = "download");
                if (D) h = (d.URL || d.webkitURL || d).createObjectURL(a), o.href = h, o.download = b, c = v.createEvent("MouseEvents"), c.initMouseEvent("click", !0, !1, d, 0, 0, 0, 0, 0, !1, !1, !1, !1, 0, null), o.dispatchEvent(c), e.readyState = e.DONE, z(), r(h);
                else {
                    d.chrome && (c && "application/octet-stream" !== c) && (j = a.slice || a.webkitSlice, a = j.call(a, 0, a.size, "application/octet-stream"), x = !0);
                    p && "download" !== b && (b += ".download");
                    if ("application/octet-stream" ===
                        c || p) g = d;
                    w ? (q += a.size, w(d.TEMPORARY, q, n(function(c) {
                        c.root.getDirectory("saved", i, n(function(c) {
                            var d = function() {
                                c.getFile(b, i, n(function(b) {
                                        b.createWriter(n(function(c) {
                                            c.onwriteend = function(a) {
                                                g.location.href = b.toURL();
                                                e.readyState = e.DONE;
                                                s(e, "writeend", a);
                                                r(b)
                                            };
                                            c.onerror = function() {
                                                var a = c.error;
                                                a.code !== a.ABORT_ERR && f()
                                            };
                                            ["writestart", "progress", "write", "abort"].forEach(function(a) {
                                                c["on" + a] = e["on" + a]
                                            });
                                            c.write(a);
                                            e.abort = function() {
                                                c.abort();
                                                e.readyState = e.DONE
                                            };
                                            e.readyState = e.WRITING
                                        }), f)
                                    }),
                                    f)
                            };
                            c.getFile(b, {
                                create: false
                            }, n(function(a) {
                                a.remove();
                                d()
                            }), n(function(a) {
                                a.code === a.NOT_FOUND_ERR ? d() : f()
                            }))
                        }), f)
                    }), f)) : f()
                }
            },
            i = A.prototype;
        "undefined" !== typeof navigator && navigator.msSaveOrOpenBlob ? j = function(a, b) {
            return navigator.msSaveOrOpenBlob(y(a), b)
        } : (i.abort = function() {
            this.readyState = this.DONE;
            s(this, "abort")
        }, i.readyState = i.INIT = 0, i.WRITING = 1, i.DONE = 2, i.error = i.onwritestart = i.onprogress = i.onwrite = i.onabort = i.onerror = i.onwriteend = null, j = function(a, b) {
            return new A(a, b)
        })
    }
    var _getTS = function()
    {
    	var date = new Date();
    	date.setMinutes(date.getMinutes() - date.getTimezoneOffset());
    	var stDate = date.toJSON().slice(0, 19);
    	
    	return '_' + stDate.replace(/:|-|T/g,"");
    }
    var t = function(a,
            b) {
            var e = "*" === a.filename && "*" !== a.title && a.title !== k ? a.title : a.filename; - 1 !== e.indexOf("*") && (e = e.replace("*", g("title").text()));
            e = e.replace(/[^a-zA-Z0-9_\u00A1-\uFFFF\.,\-_ !\(\)]/g, "");
            
            e += _getTS();
            
            return b === k || !0 === b ? e + a.extension : e
        },
        F = function(a) {
            a = a.title;
            return -1 !== a.indexOf("*") ? a.replace("*", g("title").text()) : a
        },
        u = function(a) {
            return a.newline ? a.newline : navigator.userAgent.match(/Windows/) ? "\r\n" : "\n"
        },
        B = function(a, b) {
            for (var e = u(b), c = a.buttons.exportData(b.exportOptions), d = b.fieldBoundary, h = b.fieldSeparator,
                    f = RegExp(d, "g"), g = b.escapeChar !== k ? b.escapeChar : "\\", i = function(a) {
                        for (var b = "", c = 0, e = a.length; c < e; c++) 0 < c && (b += h), b += d ? d + ("" + a[c]).replace(f, g + d) + d : a[c];
                        return b
                    }, n = b.header ? i(c.header) + e : "", j = b.footer ? e + i(c.footer) : "", l = [], m = 0, o = c.body.length; m < o; m++) l.push(i(c.body[m]));
            return {
                str: n + l.join(e) + j,
                rows: l.length
            }
        },
        C = function() {
            return -1 !== navigator.userAgent.indexOf("Safari") && -1 === navigator.userAgent.indexOf("Chrome") && -1 === navigator.userAgent.indexOf("Opera")
        },
        m = {
            "_rels/.rels": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">\t<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>',
            "xl/_rels/workbook.xml.rels": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">\t<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/></Relationships>',
            "[Content_Types].xml": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">\t<Default Extension="xml" ContentType="application/xml"/>\t<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>\t<Default Extension="jpeg" ContentType="image/jpeg"/>\t<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>\t<Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/></Types>',
            "xl/workbook.xml": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">\t<fileVersion appName="xl" lastEdited="5" lowestEdited="5" rupBuild="24816"/>\t<workbookPr showInkAnnotation="0" autoCompressPictures="0"/>\t<bookViews>\t\t<workbookView xWindow="0" yWindow="0" windowWidth="25600" windowHeight="19020" tabRatio="500"/>\t</bookViews>\t<sheets>\t\t<sheet name="Sheet1" sheetId="1" r:id="rId1"/>\t</sheets></workbook>',
            "xl/worksheets/sheet1.xml": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x14ac" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">\t<sheetData>\t\t__DATA__\t</sheetData></worksheet>'
        };
    l.ext.buttons.copyHtml5 = {
        className: "buttons-copy buttons-html5",
        text: function(a) {
            return a.i18n("buttons.copy", "Copy")
        },
        action: function(a, b, d, c) {
            a = B(b, c);
            c = a.str;
            d = g("<div/>").css({
                height: 1,
                width: 1,
                overflow: "hidden",
                position: "fixed",
                top: 0,
                left: 0
            });
            c = g("<textarea readonly/>").val(c).appendTo(d);
            if (f.queryCommandSupported("copy")) {
                d.appendTo("body");
                c[0].focus();
                c[0].select();
                try {
                    f.execCommand("copy");
                    d.remove();
                    b.buttons.info(b.i18n("buttons.copyTitle", "Copy to clipboard"), b.i18n("buttons.copySuccess", {
                            1: "Copied one row to clipboard",
                            _: "Copied %d rows to clipboard"
                        },
                        a.rows), 2E3);
                    return
                } catch (i) {}
            }
            a = g("<span>" + b.i18n("buttons.copyKeys", "Press <i>ctrl</i> or <i>⌘</i> + <i>C</i> to copy the table data<br>to your system clipboard.<br><br>To cancel, click this message or press escape.") + "</span>").append(d);
            b.buttons.info(b.i18n("buttons.copyTitle", "Copy to clipboard"), a, 0);
            c[0].focus();
            c[0].select();
            var h = g(a).closest(".dt-button-info"),
                j = function() {
                    h.off("click.buttons-copy");
                    g(f).off(".buttons-copy");
                    b.buttons.info(!1)
                };
            h.on("click.buttons-copy", j);
            g(f).on("keydown.buttons-copy",
                function(a) {
                    27 === a.keyCode && j()
                }).on("copy.buttons-copy cut.buttons-copy", function() {
                j()
            })
        },
        exportOptions: {},
        fieldSeparator: "\t",
        fieldBoundary: "",
        header: !0,
        footer: !1
    };
    l.ext.buttons.csvHtml5 = {
        className: "buttons-csv buttons-html5",
        available: function() {
            return d.FileReader !== k && d.Blob
        },
        text: function(a) {
            return a.i18n("buttons.csv", "CSV")
        },
        action: function(a, b, d, c) {
            u(c);
            a = B(b, c).str;
            b = c.charset;
            !1 !== b ? (b || (b = f.characterSet || f.charset), b && (b = ";charset=" + b)) : b = "";
            j(new Blob([a], {
                type: "text/csv" + b
            }), t(c))
        },
        filename: "*",
        extension: ".csv",
        exportOptions: {},
        fieldSeparator: ",",
        fieldBoundary: '"',
        escapeChar: '"',
        charset: null,
        header: !0,
        footer: !1
    };
    l.ext.buttons.excelHtml5 = {
        className: "buttons-excel buttons-html5",
        available: function() {
            return d.FileReader !== k && d.JSZip !== k && !C()
        },
        text: function(a) {
            return a.i18n("buttons.excel", "Excel")
        },
        action: function(a, b, e, c) {
            a = "";
            b = b.buttons.exportData(c.exportOptions);
            e = function(a) {
                for (var b = [], c = 0, d = a.length; c < d; c++) {
                    if (null === a[c] || a[c] === k) a[c] = "";
                    b.push("number" === typeof a[c] ||
                        a[c].match && a[c].match(/^-?[0-9\.]+$/) && "0" !== a[c].charAt(0) ? '<c t="n"><v>' + a[c] + "</v></c>" : '<c t="inlineStr"><is><t>' + (!a[c].replace ? a[c] : a[c].replace(/&(?!amp;)/g, "&amp;").replace(/[\x00-\x1F\x7F-\x9F]/g, "")) + "</t></is></c>")
                }
                return "<row>" + b.join("") + "</row>"
            };
            c.header && (a += e(b.header));
            for (var f = 0, h = b.body.length; f < h; f++) a += e(b.body[f]);
            c.footer && (a += e(b.footer));
            var b = new d.JSZip,
                e = b.folder("_rels"),
                f = b.folder("xl"),
                h = b.folder("xl/_rels"),
                g = b.folder("xl/worksheets");
            b.file("[Content_Types].xml",
                m["[Content_Types].xml"]);
            e.file(".rels", m["_rels/.rels"]);
            f.file("workbook.xml", m["xl/workbook.xml"]);
            h.file("workbook.xml.rels", m["xl/_rels/workbook.xml.rels"]);
            g.file("sheet1.xml", m["xl/worksheets/sheet1.xml"].replace("__DATA__", a));
            j(b.generate({
                type: "blob"
            }), t(c))
        },
        filename: "*",
        extension: ".xlsx",
        exportOptions: {},
        header: !0,
        footer: !1
    };
    l.ext.buttons.pdfHtml5 = {
        className: "buttons-pdf buttons-html5",
        available: function() {
            return d.FileReader !== k && d.pdfMake
        },
        text: function(a) {
            return a.i18n("buttons.pdf",
                "PDF")
        },
        action: function(a, b, e, c) {
            u(c);
            a = b.buttons.exportData(c.exportOptions);
            b = [];
            c.header && b.push(g.map(a.header, function(a) {
                return {
                    text: "string" === typeof a ? a : a + "",
                    style: "tableHeader"
                }
            }));
            for (var f = 0, e = a.body.length; f < e; f++) b.push(g.map(a.body[f], function(a) {
                return {
                    text: "string" === typeof a ? a : a + "",
                    style: f % 2 ? "tableBodyEven" : "tableBodyOdd"
                }
            }));
            c.footer && b.push(g.map(a.footer, function(a) {
                return {
                    text: "string" === typeof a ? a : a + "",
                    style: "tableFooter"
                }
            }));
            a = {
                pageSize: c.pageSize,
                pageOrientation: c.orientation,
                content: [{
                    table: {
                        headerRows: 1,
                        body: b
                    },
                    layout: "noBorders"
                }],
                styles: {
                    tableHeader: {
                        bold: !0,
                        fontSize: 11,
                        color: "white",
                        fillColor: "#2d4154",
                        alignment: "center"
                    },
                    tableBodyEven: {},
                    tableBodyOdd: {
                        fillColor: "#f3f3f3"
                    },
                    tableFooter: {
                        bold: !0,
                        fontSize: 11,
                        color: "white",
                        fillColor: "#2d4154"
                    },
                    title: {
                        alignment: "center",
                        fontSize: 15
                    },
                    message: {}
                },
                defaultStyle: {
                    fontSize: 10
                }
            };
            c.message && a.content.unshift({
                text: c.message,
                style: "message",
                margin: [0, 0, 0, 12]
            });
            c.title && a.content.unshift({
                text: F(c, !1),
                style: "title",
                margin: [0, 0,
                    0, 12
                ]
            });
            c.customize && c.customize(a);
            a = d.pdfMake.createPdf(a);
            "open" === c.download && !C() ? a.open() : a.getBuffer(function(a) {
                a = new Blob([a], {
                    type: "application/pdf"
                });
                j(a, t(c))
            })
        },
        title: "*",
        filename: "*",
        extension: ".pdf",
        exportOptions: {},
        orientation: "portrait",
        pageSize: "A4",
        header: !0,
        footer: !1,
        message: null,
        customize: null,
        download: "download"
    };
    return l.Buttons
});